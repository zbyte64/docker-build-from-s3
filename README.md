Mounts S3 folder and builds the docker image from it.


Environment variables:

- BUCKET_NAME
- BUCKET_DIRECTORY
- DOCKER_REGISTRY
- DOCKER_IMAGE_NAME
- DOCKER_IMAGE_VERSION


```
docker build . -t build-from-s3
docker run -it -v /var/run/docker.sock:/var/run/docker.sock build-from-s3
```
