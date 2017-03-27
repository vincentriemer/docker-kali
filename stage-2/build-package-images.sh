#!/bin/bash
set -e

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"

for D in $SDIR/images/*/
do
  bash $Dbuild.sh
done
