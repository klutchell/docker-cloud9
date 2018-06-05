FROM resin/raspberrypi3-node:8.11.2

LABEL maintainer="kylemharding@gmail.com"

# allow building on x86
RUN [ "cross-build-start" ]

# avoid debconf warnings
ENV DEBIAN_FRONTEND noninteractive

# set c9 workspace and port
ENV C9_WORKSPACE /workspace
ENV C9_PORT 8080

# install updates and common utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-transport-https \
	bash-completion \
	sshfs \
	tmux \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# work in app dir for cloud9
WORKDIR /usr/src/app

# clone & install cloud9 core 
RUN git clone https://github.com/c9/core.git . \
	&& npm config set unsafe-perm true \
	&& scripts/install-sdk.sh

# copy src files
COPY . /usr/src/app/

# store c9 workspace in a volume
VOLUME $C9_WORKSPACE

# run start script on boot
CMD ["/bin/sh", "start.sh"]

# end cross build
RUN [ "cross-build-end" ]

