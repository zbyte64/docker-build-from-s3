#!/bin/bash

if [ $BUCKET_NAME ]; then
  #do s3 mount and export a git index
  s3fs ${BUCKET_NAME}:${BUCKET_DIRECTORY} /var/source-code/.git -o retries=5,umask=0222
fi

if [ $GIT_TARBALL_URL ]; then
  wget ${GIT_TARBALL_URL} /tmp/bare-git-tree.tar.gz
  tar -x /tmp/bare-git-tree.tar.gz -C /var/source-code/.git
  rm /tmp/bare-git-tree.tar.gz
fi

cd /var/source-code

if [ $GIT_CHECKOUT ]; then
  git checkout -f ${GIT_CHECKOUT}
fi


#TODO support multiple tags
if [ $DOCKER_REGISTRY ]; then
  docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} /var/source-code
  docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
else
  docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} /var/source-code
fi
