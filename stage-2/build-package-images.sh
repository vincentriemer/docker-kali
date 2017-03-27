#!/bin/bash
set -e

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"

BUILD="build.sh"

for DIR in $SDIR/images/*/
do
  bash $DIR$BUILD
done
