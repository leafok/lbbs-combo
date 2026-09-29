#!/bin/sh
set -eu

DOCKERHUB_PLATFORMS="${DOCKERHUB_PLATFORMS:-linux/amd64}"
RUN_PLATFORM="${RUN_PLATFORM:-linux/amd64}"

git submodule update --init --recursive

if ! docker buildx ls | grep -q multi-platform-builder; then
    docker buildx create --use --name multi-platform-builder --platform="$DOCKERHUB_PLATFORMS"
else
    docker buildx use multi-platform-builder
fi

docker buildx inspect multi-platform-builder --bootstrap

# Pass 1: build once for every target platform to populate the BuildKit cache.
# A multi-platform result can neither be loaded nor used locally, hence no
# --load / --push here.
docker buildx build . --platform="$DOCKERHUB_PLATFORMS" --file Dockerfile/dockerfile.solr --tag leafok/lbbs-solr:combo
docker buildx build . --platform="$DOCKERHUB_PLATFORMS" --file Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:combo
docker buildx build . --platform="$DOCKERHUB_PLATFORMS" --file Dockerfile/dockerfile.php --tag leafok/lbbs-php:combo
docker buildx build . --platform="$DOCKERHUB_PLATFORMS" --file Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:combo

# Pass 2: build for the local run-time platform and load the images
docker buildx build . --platform="$RUN_PLATFORM" --file Dockerfile/dockerfile.solr --tag leafok/lbbs-solr:combo --load
docker buildx build . --platform="$RUN_PLATFORM" --file Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:combo --load
docker buildx build . --platform="$RUN_PLATFORM" --file Dockerfile/dockerfile.php --tag leafok/lbbs-php:combo --load
docker buildx build . --platform="$RUN_PLATFORM" --file Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:combo --load
