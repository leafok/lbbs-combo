#!/bin/sh

git submodule update --init --recursive

docker build ./leafok_bbs --file ./leafok_bbs/Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:latest
docker build ./leafok_bbs --file ./leafok_bbs/Dockerfile/dockerfile.php --tag leafok/lbbs-php:latest
docker build ./lbbs --file ./lbbs/Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:latest
docker build . --file Dockerfile/dockerfile.apache.testing --tag leafok/lbbs-apache:testing
docker build . --file Dockerfile/dockerfile.php.testing --tag leafok/lbbs-php:testing
docker build . --file Dockerfile/dockerfile.bbsd.testing --tag leafok/lbbs-bbsd:testing
