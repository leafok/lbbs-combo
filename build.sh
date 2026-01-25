#!/bin/sh

if [ ! -n "$DOCKER_PLATFORMS" ]; then
    DOCKER_PLATFORMS="linux/amd64,linux/arm64"
fi

if [ ! -n "$RUN_PLATFORM" ]; then
    RUN_PLATFORM="linux/amd64"
fi

git submodule update --init --recursive

docker buildx ls | grep multi-platform-builder

if [ $? -ne 0 ]; then
    docker buildx create --use --name multi-platform-builder --platform=$DOCKER_PLATFORMS
else
    docker buildx use multi-platform-builder
fi

docker buildx inspect multi-platform-builder --bootstrap

docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.solr --tag leafok/lbbs-solr:combo
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:combo
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.php --tag leafok/lbbs-php:combo
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:combo

docker buildx build . --platform=$RUN_PLATFORM --file Dockerfile/dockerfile.solr --tag leafok/lbbs-solr:combo --load
docker buildx build . --platform=$RUN_PLATFORM --file Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:combo --load
docker buildx build . --platform=$RUN_PLATFORM --file Dockerfile/dockerfile.php --tag leafok/lbbs-php:combo --load
docker buildx build . --platform=$RUN_PLATFORM --file Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:combo --load
