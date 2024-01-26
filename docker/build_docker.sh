#!/usr/bin/env bash

CURRENT_PATH=$(cd $(dirname $0) ; pwd)
IMAGE_NAME="pika/pika_build:v0.1"

#docker build --no-cache -t ${IMAGE_NAME} -f ${CURRENT_PATH}/Dockerfile ${CURRENT_PATH}
docker build -t ${IMAGE_NAME} -f ${CURRENT_PATH}/Dockerfile_build_env ${CURRENT_PATH}

