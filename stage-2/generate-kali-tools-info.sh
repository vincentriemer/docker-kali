#!/bin/bash

rm -f config.json

function get_alternatives() {
  perl -lwe 'foreach (`dpkg -L @ARGV`) {chomp; ++$p{$_}} foreach (</bin/* /sbin/* /usr/bin/* /usr/sbin/* /usr/local/sbin/*>) {$e = readlink; next unless defined $e and $e =~ m!^/etc/alternatives/!; $t = readlink $e; print if $p{$t}}' $1
}

export -f get_alternatives

function get_binaries() {
  echo $(dpkg -L $1 | sed -n 's!^\(/s\?bin\|/usr/s\?bin\|/usr/local/sbin\/usr/sbin\)/!!p' | sort)
}

export -f get_binaries

function get_executables() {
  PACKAGE_NAME=$1
  EXECUTABLES=$(echo $({ get_alternatives $1 ; get_binaries $1 ; }) | tr ' ' '\n' | xargs -L1 -r sh -c 'basename $1' dummy | awk '{ print "\""$1"\"" }' | tr '\n' ','| sed 's/;$//')

  if [ ${#EXECUTABLES} -ge 1 ]; then
    EXECUTABLES=${EXECUTABLES::-1}
    echo "\"$PACKAGE_NAME\": [$EXECUTABLES],"
  fi
}

export -f get_executables

OUTPUT=$(apt-cache show kali-linux-top10 | \
  grep Depends | \
  tr ',' '\n' | \
  sed -n '1!p' | \
  xargs -n1 bash -c 'get_executables "$@"' _)
OUTPUT=${OUTPUT::-1}

echo "{ $OUTPUT }" > "config.json"