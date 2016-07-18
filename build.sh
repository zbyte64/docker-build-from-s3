#!/bin/bash

#echo MYIDENTITY:MYCREDENTIAL > /etc/passwd-s3fs

#do s3 mount
s3fs ${BUCKET_NAME}:${BUCKET_DIRECTORY} /tmp/target-code


#TODO support multiple tags
#do build
docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION} /tmp/target-code


#push build
docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_VERSION}
