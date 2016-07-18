FROM jpetazzo/dind
MAINTAINER zbyte64@gmail.com

ENV S3FS_VERSION "1.80"

RUN apt-get install -y build-essential git libfuse-dev libcurl4-openssl-dev libxml2-dev mime-support automake libtool
RUN apt-get install -y pkg-config libssl-dev
ADD https://github.com/s3fs-fuse/s3fs-fuse/archive/v${S3FS_VERSION}.tar.gz /tmp/s3fs-fuse.tar.gz

WORKDIR /tmp

RUN tar xvzf /tmp/s3fs-fuse.tar.gz
WORKDIR /tmp/s3fs-fuse-${S3FS_VERSION}
RUN ./autogen.sh
RUN ./configure --prefix=/usr
RUN make
RUN make install



