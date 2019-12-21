ARG BUILD_FROM
FROM $BUILD_FROM

ARG MAKE_THREADS=8

COPY etc/qemu-arm-static /usr/bin/
COPY etc/qemu-aarch64-static /usr/bin/

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
        build-essential

COPY download/openfst-1.6.9.tar.gz /

RUN cd / && tar -xf openfst-1.6.9.tar.gz && cd openfst-1.6.9/ && \
    ./configure \
        --prefix=/build \
        --enable-far \
        --enable-static \
        --enable-shared \
        --enable-ngram-fsts && \
    make -j $MAKE_THREADS && \
    make install