FROM node:8

ARG BUILD_DATE=not provided
ARG BUILD_VERSION=not provided

LABEL build_version="${BUILD_VERSION}"
LABEL build_date="${BUILD_DATE}"
LABEL maintainer="kylemharding@gmail.com"

# set c9 env vars
ENV C9_WORKSPACE /workspace
ENV C9_PORT 80
ENV C9_USER root
ENV C9_PASS	resin

# install updates and common utilities
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && apt-get install -yq --no-install-recommends \
	apt-transport-https \
	bash-completion \
	ca-certificates \
	curl \
	git \
	gnupg2 \
	software-properties-common \
	sshfs \
	tmux \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add docker-ce repo
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
	&& echo "deb [arch=armhf] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" | \
	tee /etc/apt/sources.list.d/docker.list
	
# install docker-ce
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && apt-get install -yq --no-install-recommends \
	docker \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# work in app dir for cloud9
WORKDIR /usr/src/app

# clone & install cloud9 core 
RUN git clone --depth 1 https://github.com/c9/core.git . \
	&& npm config set unsafe-perm true \
	&& scripts/install-sdk.sh

# copy src files
COPY start.sh ./

# store c9 workspace and home dir
VOLUME $C9_WORKSPACE /root

# run start script on boot
CMD ["/bin/sh", "start.sh"]

