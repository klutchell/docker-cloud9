
DOCKER_REPO		:= klutchell/cloud9
CACHE_TAG		:= $$(git describe --tags)
BUILD_VERSION	:= $$(git describe --tags --long --dirty --always)
BUILD_DATE		:= $$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IMAGE_NAME		:= ${DOCKER_REPO}:${BUILD_VERSION}
LATEST_NAME		:= ${DOCKER_REPO}:latest
DOCKERFILE_PATH	:= ./Dockerfile

.DEFAULT_GOAL	:= build

tag-major: VERSION	:= $$(docker run --rm treeder/bump --input "${CACHE_TAG}" major)
tag-major:
	@git tag -a ${VERSION} -m "version ${VERSION}"
	@git push --tags

tag-minor: VERSION	:= $$(docker run --rm treeder/bump --input "${CACHE_TAG}" minor)
tag-minor:
	@git tag -a ${VERSION} -m "version ${VERSION}"
	@git push --tags

tag-patch: VERSION	:= $$(docker run --rm treeder/bump --input "${CACHE_TAG}" patch)
tag-patch:
	@git tag -a ${VERSION} -m "version ${VERSION}"
	@git push --tags

build:
	./hooks/build
	@docker tag ${IMAGE_NAME} ${LATEST_NAME}

build-nc:
	./hooks/build --no-cache
	@docker tag ${IMAGE_NAME} ${LATEST_NAME}

push:
	@docker push ${IMAGE_NAME}

tag:			tag-patch

release:		build push

armhf-build:	IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${BUILD_VERSION}
armhf-build:	LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-build:	DOCKERFILE_PATH	:= ./Dockerfile.armhf
armhf-build:	build

armhf-build-nc:	IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${BUILD_VERSION}
armhf-build-nc:	LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-build-nc:	DOCKERFILE_PATH	:= ./Dockerfile.armhf
armhf-build-nc:	build-nc

armhf-push:		IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${BUILD_VERSION}
armhf-push:		LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-push:		DOCKERFILE_PATH	:= ./Dockerfile.armhf
armhf-push:		push

armhf-release:	armhf-build armhf-push

armhf:			armhf-build

