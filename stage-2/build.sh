#!/bin/bash
set -e
docker login -u $DOCKER_USER -p $DOCKER_PASS

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"
CONFIG_BUILDER_TAG="vincentriemer/kali:config-builder"

docker build -t $CONFIG_BUILDER_TAG $SDIR

docker run --rm \
    -v $SDIR:/usr/src/app \
    $CONFIG_BUILDER_TAG \
    bash -c "./generate-kali-tools-info.sh"

docker run --rm \
    -v $SDIR:/usr/src/app \
    $CONFIG_BUILDER_TAG \
    bash -c "npm cache clean && npm i && ./generate.js"

./build-package-images.sh

