#!/bin/bash
set -e

SDIR="$( cd "$( dirname "\$\{BASH_SOURCE[0]\}" )" && pwd )"
REPO=vincentriemer/docker-kali
TAG=base

BUILD_TAG=$REPO:$TAG
docker build -t $BUILD_TAG $SDIR

if [ -z ${DOCKER_USER+x} ]; then
  echo "DOCKER_USER not in env, skipping push..."
else
  docker login -u $DOCKER_USER -p $DOCKER_PASS
  docker push $BUILD_TAG
fi

