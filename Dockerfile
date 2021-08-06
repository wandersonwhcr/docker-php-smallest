FROM alpine:3.14

ARG PHP_VERSION

WORKDIR /usr/src/php

RUN wget -q https://github.com/php/php-src/archive/refs/tags/php-${PHP_VERSION}.tar.gz \
    && tar --strip-components 1 -xzf php-${PHP_VERSION}.tar.gz \
    && rm php-${PHP_VERSION}.tar.gz
