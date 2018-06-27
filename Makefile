
DOCKER_REPO		:= klutchell/cloud9
CACHE_TAG			:= $$(git describe --tags)
BUILD_VERSION	:= $$(git describe --tags --long --dirty --always)
BUILD_DATE		:= $$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IMAGE_NAME		:= ${DOCKER_REPO}:${CACHE_TAG}
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
	@docker build \
	--build-arg "BUILD_VERSION=${BUILD_VERSION}" \
	--build-arg "BUILD_DATE=${BUILD_DATE}" \
	--tag ${IMAGE_NAME} \
	--file ${DOCKERFILE_PATH} \
	.
	@docker tag ${IMAGE_NAME} ${LATEST_NAME}

build-nc:
	@docker build --no-cache
	--build-arg "BUILD_VERSION=${BUILD_VERSION}" \
	--build-arg "BUILD_DATE=${BUILD_DATE}" \
	--tag ${IMAGE_NAME} \
	--file ${DOCKERFILE_PATH} \
	.
	@docker tag ${IMAGE_NAME} ${LATEST_NAME}

push:
	@docker push ${IMAGE_NAME}

tag:			tag-patch

release:		build push

armhf-build:	IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${CACHE_TAG}
armhf-build:	LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-build:	DOCKERFILE_PATH	:= ./armhf/Dockerfile
armhf-build:	build

armhf-build-nc:	IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${CACHE_TAG}
armhf-build-nc:	LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-build-nc:	DOCKERFILE_PATH	:= ./armhf/Dockerfile
armhf-build-nc:	build-nc

armhf-push:		IMAGE_NAME		:= ${DOCKER_REPO}:armhf-${CACHE_TAG}
armhf-push:		LATEST_NAME		:= ${DOCKER_REPO}:armhf-latest
armhf-push:		DOCKERFILE_PATH	:= ./armhf/Dockerfile
armhf-push:		push

armhf-release:	armhf-build armhf-push

armhf:			armhf-build

