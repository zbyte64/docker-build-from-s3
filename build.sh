#!/bin/bash

if [ $BUCKET_NAME ]; then
  mkdir -p /tmp/target-code/.git

  #do s3 mount and export a git index
  s3fs ${BUCKET_NAME}:${BUCKET_DIRECTORY} /tmp/target-code/.git -o retries=5,umask=0222
  cd /tmp/target-code
  git archive ${GIT_CHECKOUT} | tar -x -C /var/source-code
fi


#TODO support multiple tags
if [ $DOCKER_REGISTRY ]; then
  docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} /var/source-code
  docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
else
  docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} /var/source-code
fi
