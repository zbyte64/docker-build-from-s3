#!/bin/bash
set -e

if [ $BUCKET_NAME ]; then
  #do s3 mount and export a git index
  s3fs ${BUCKET_NAME}:${BUCKET_DIRECTORY} /var/source-code/.git -o retries=5,umask=0222
fi

if [ $GIT_TARBALL_URL ]; then
  wget ${GIT_TARBALL_URL} -O /tmp/bare-git-tree.tar.gz
  tar -xf /tmp/bare-git-tree.tar.gz -C /var/source-code/.git
  rm /tmp/bare-git-tree.tar.gz
fi

cd /var/source-code

git config --local --bool core.bare false

if [ $GIT_CHECKOUT ]; then
  git checkout -f ${GIT_CHECKOUT}
fi

if [ ! -f /var/source-code/Dockerfile ]; then
  echo "Dockerfile not found" 1>&2
  exit 1
fi


#TODO support multiple tags
if [ $DOCKER_REGISTRY ]; then
  docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} /var/source-code
  docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
else
  docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} /var/source-code
fi
