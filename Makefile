
DOCKER_REPO		:= klutchell/cloud9
VERSION			:= $$(cat ./VERSION)
BUILD_DATE		:= $$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IMAGE_NAME		:= ${DOCKER_REPO}:${VERSION}
LATEST_NAME		:= ${DOCKER_REPO}:latest
DOCKERFILE_PATH	:= ./Dockerfile

.DEFAULT_GOAL	:= build

bump:
	@docker run --rm -v "${PWD}":/app treeder/bump patch

build:
	@docker build \
	--build-arg "VERSION=${VERSION}" \
	--build-arg "BUILD_DATE=${BUILD_DATE}" \
	--tag ${IMAGE_NAME} \
	--file ${DOCKERFILE_PATH} \
	.
	@docker tag ${IMAGE_NAME} ${LATEST_NAME}

build-nc:
	@docker build --no-cache
	--build-arg "VERSION=${VERSION}" \
	--build-arg "BUILD_DATE=${BUILD_DATE}" \
	--tag ${IMAGE_NAME} \
	--file ${DOCKERFILE_PATH} \
	.
	@docker tag ${IMAGE_NAME} ${LATEST_NAME}

push:
	@docker push ${IMAGE_NAME}

release: bump build push

armhf-build:	IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${VERSION}
armhf-build:	LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-build:	DOCKERFILE_PATH	:= ./armhf/Dockerfile
armhf-build:	build

armhf-build-nc:	IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${VERSION}
armhf-build-nc:	LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-build-nc:	DOCKERFILE_PATH	:= ./armhf/Dockerfile
armhf-build-nc:	build-nc

armhf-push:		IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${VERSION}
armhf-push:		LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-push:		DOCKERFILE_PATH	:= ./armhf/Dockerfile
armhf-push:		push

armhf-release:	bump armhf-build armhf-push

armhf:		armhf-build

