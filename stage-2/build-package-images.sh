#!/bin/bash
set -e

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"

for D in `cd $SDIR/images && find . d`
do
  bash $D/build.sh
done