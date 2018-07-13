FROM node:8

ARG BUILD_DATE
ARG BUILD_VERSION

LABEL build_version="${BUILD_VERSION}"
LABEL build_date="${BUILD_DATE}"
LABEL maintainer="kylemharding@gmail.com"

# set c9 env vars
ENV C9_WORKSPACE /workspace
ENV C9_PORT 8080

# docker-in-docker daemon options
ENV DIND_OPTS ""

# install updates and common utilities
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && apt-get install -yq --no-install-recommends \
	apt-transport-https \
	aufs-tools \
	bash-completion \
	ca-certificates \
	curl \
	git \
	gnupg2 \
	software-properties-common \
	sudo \
	sshfs \
	tmux \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# add docker-ce repo
RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add - \
	&& echo "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable" | \
	tee /etc/apt/sources.list.d/docker.list
	
# install docker-ce
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && apt-get install -yq --no-install-recommends \
	docker-ce \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# work in app dir
WORKDIR /usr/src/app

# clone & install cloud9 core 
RUN git clone --depth 1 https://github.com/c9/core.git . \
	&& npm config set unsafe-perm true \
	&& scripts/install-sdk.sh

# copy src files
COPY start.sh ./

# volumes for workspace, home dir, and docker graph
VOLUME ${C9_WORKSPACE} /root /var/lib/docker

# run start script on boot
CMD ["/bin/sh", "start.sh"]

