#!/bin/sh

git submodule update --init --recursive

docker build ./leafok_bbs --file ./leafok_bbs/Dockerfile/dockerfile.apache --tag leafok/lbbs-apache:base
docker build ./leafok_bbs --file ./leafok_bbs/Dockerfile/dockerfile.php --tag leafok/lbbs-php:latest
docker build ./lbbs --file ./lbbs/Dockerfile/dockerfile.bbsd --tag leafok/lbbs-bbsd:base
docker build . --file Dockerfile/dockerfile.apache.testing --tag leafok/lbbs-apache:testing
docker build . --file Dockerfile/dockerfile.bbsd.testing --tag leafok/lbbs-bbsd:testing
