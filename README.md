Mounts S3 folder and builds the docker image from it.

Running
=======

To run you must expose a docker service to the container.
This can be done by binding the docker socket as a volume or setting the `DOCKER_HOST` environment variable.

```
docker build . -t build-from-s3
docker run -it -v /var/run/docker.sock:/var/run/docker.sock ... build-from-s3
```

Environment variables:

- DOCKER_IMAGE_NAME
- DOCKER_IMAGE_VERSION


Building From Volume
====================

Specify a volume for `/var/source-code` and have it host the target code base.


Building From S3
================

Be sure to set up S3 credentials:
```
echo MYIDENTITY:MYCREDENTIAL > passwd-s3fs
docker cp passwd-s3fs build-from-s3:/etc/passwd-s3fs
```

Environment variables:

- BUCKET_NAME
- BUCKET_DIRECTORY
- GIT_CHECKOUT


Pushing To Registry
===================

Environment variables:

- DOCKER_REGISTRY
