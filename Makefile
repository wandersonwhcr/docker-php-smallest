GIT_SHA_SHORT=$(shell git rev-parse --short HEAD)

.PHONY: all
all: build

.PHONY: build
build:
	docker build . \
		--file Dockerfile \
		--tag wandersonwhcr/php-smallest:${GIT_SHA_SHORT}
