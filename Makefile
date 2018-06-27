
DOCKER_REPO		:= klutchell/cloud9
VERSION			:= $$(git describe --tags)
BUILD_VERSION	:= $$(git describe --tags --long --dirty --always)
BUILD_DATE		:= $$(date -u +"%Y-%m-%dT%H:%M:%SZ")

IMAGE_NAME		:= ${DOCKER_REPO}:${VERSION}
LATEST_NAME		:= ${DOCKER_REPO}:latest
DOCKERFILE_PATH	:= ./Dockerfile

.DEFAULT_GOAL	:= build

bump-major: VERSION	:= $$(docker run --rm treeder/bump --input "${VERSION}" major)
bump-major:
	@git tag -a ${VERSION} -m "version ${VERSION}"
	@git push --tags

bump-minor: VERSION	:= $$(docker run --rm treeder/bump --input "${VERSION}" minor)
bump-minor:
	@git tag -a ${VERSION} -m "version ${VERSION}"
	@git push --tags

bump-patch: VERSION	:= $$(docker run --rm treeder/bump --input "${VERSION}" patch)
bump-patch:
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

bump:			bump-patch

release:		build push

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

armhf-release:	armhf-build armhf-push

armhf:			armhf-build

