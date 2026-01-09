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

docker buildx build ./leafok_bbs --platform=$DOCKER_PLATFORMS --file ./leafok_bbs/Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:latest
docker buildx build ./leafok_bbs --platform=$DOCKER_PLATFORMS --file ./leafok_bbs/Dockerfile/dockerfile.php --tag leafok/lbbs-php:latest
docker buildx build ./lbbs --platform=$DOCKER_PLATFORMS --file ./lbbs/Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:latest
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.apache.testing --tag leafok/lbbs-apache:testing
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.php.testing --tag leafok/lbbs-php:testing
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.bbsd.testing --tag leafok/lbbs-bbsd:testing

docker buildx build ./leafok_bbs --platform=$RUN_PLATFORM --file ./leafok_bbs/Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:latest --load
docker buildx build ./leafok_bbs --platform=$DOCKER_PLATFORMS --file ./leafok_bbs/Dockerfile/dockerfile.php --tag leafok/lbbs-php:latest --load
docker buildx build ./lbbs --platform=$DOCKER_PLATFORMS --file ./lbbs/Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:latest --load
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.apache.testing --tag leafok/lbbs-apache:testing --load
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.php.testing --tag leafok/lbbs-php:testing --load
docker buildx build . --platform=$DOCKER_PLATFORMS --file Dockerfile/dockerfile.bbsd.testing --tag leafok/lbbs-bbsd:testing --load
