ARG DOCKER_IMAGE_TAG

FROM ${DOCKER_IMAGE_TAG} AS base

RUN apk add --no-cache upx \
    && upx --best /usr/local/bin/php

FROM scratch

COPY --from=base /usr/local/bin/php /usr/local/bin/php

ENTRYPOINT ["/usr/local/bin/php"]

WORKDIR /app
