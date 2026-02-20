FROM alpine:3.14 AS builder

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
        --disable-cgi \
        --disable-debug --disable-phpdbg \
        --with-config-file-path="/usr/local/etc/php" \
        --with-config-file-scan-dir="/usr/local/etc/php/conf.d" \
        CFLAGS="-O3 -march=native" \
    && sed -i 's/-export-dynamic/-all-static/g' Makefile

RUN make \
    && make install

RUN apk add --no-cache upx \
    && upx --best /usr/local/bin/php

FROM scratch

COPY --from=builder /usr/local/bin/php /usr/local/bin/php

ENTRYPOINT ["/usr/local/bin/php"]

WORKDIR /app
