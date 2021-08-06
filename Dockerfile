FROM alpine:3.14

ARG PHP_VERSION

WORKDIR /usr/src/php

RUN wget -q https://github.com/php/php-src/archive/refs/tags/php-${PHP_VERSION}.tar.gz \
    && tar --strip-components 1 -xzf php-${PHP_VERSION}.tar.gz \
    && rm php-${PHP_VERSION}.tar.gz

RUN apk add --no-cache \
        alpine-sdk \
        autoconf \
        automake \
        libc6-compat \
        libtool \
    && apk add --no-cache \
        bison \
        re2c \
    && ./buildconf --force

RUN ./configure --disable-all \
        --disable-debug --disable-phpdbg \
        CFLAGS="-O3 -march=native" \
    && sed -i 's/-export-dynamic/-all-static/g' Makefile
