GIT_SHA_SHORT=$(shell git rev-parse --short HEAD)
PHP_VERSION=8.0.9

.PHONY: all
all: build

.PHONY: base
base:
	docker build . \
		--file Base.Dockerfile \
		--build-arg PHP_VERSION=${PHP_VERSION} \
		--tag wandersonwhcr/php-smallest:${GIT_SHA_SHORT}-base

.PHONY: build
build: base
	docker build . \
		--file Dockerfile \
		--build-arg DOCKER_IMAGE_TAG=wandersonwhcr/php-smallest:${GIT_SHA_SHORT}-base \
		--tag wandersonwhcr/php-smallest:${GIT_SHA_SHORT}

.PHONY: size
size: build
	docker inspect \
		--type image \
		--format '{{ .Size }}' \
		wandersonwhcr/php-smallest:${GIT_SHA_SHORT} \
	| numfmt --to iec --format '%.2f'

.PHONY: clean
clean:
	docker image list wandersonwhcr/php-smallest --quiet \
		| xargs docker image remove
