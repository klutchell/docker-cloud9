FROM resin/raspberrypi3-node

LABEL maintainer="kylemharding@gmail.com"

# allow building on x86
RUN [ "cross-build-start" ]

# set some c9 variables that can be overridden
ENV C9_WORKSPACE /workspace
ENV C9_PORT 8080

# set the correct uname for rpi3
RUN cp "$(which uname)" "/bin/uname.orig" \
	&& echo '#!/bin/sh\n/bin/uname.orig $* | sed "s/armv8l/armv7l/"' > "$(which uname)"

# install updates and common utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
	apt-transport-https \
	bash-completion \
	ca-certificates \
	curl \
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

# install docker
RUN curl -sSL https://get.docker.com/ | sh

# store c9 workspace in a volume
VOLUME $C9_WORKSPACE

# run start script on boot
CMD ["/bin/sh", "start.sh"]

# end cross build
RUN [ "cross-build-end" ]

