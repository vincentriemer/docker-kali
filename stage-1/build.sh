#!/bin/bash
set -e

docker login -u $DOCKER_USER -p $DOCKER_PASS

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"
REPO=vincentriemer/docker-kali
TAG=base

BUILD_TAG=$REPO:$TAG

docker build -t $BUILD_TAG $SDIR
docker push $BUILD_TAG

