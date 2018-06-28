#!/bin/sh

# set timezone with TZ
# eg. TZ=America/Toronto
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

if [ "${INITSYSTEM}" != "on" ]
then
    # start docker daemon in the background
    /usr/bin/dockerd --iptables=false --dns 8.8.8.8 &
fi

# start cloud9 server in the foreground
node server.js -p ${C9_PORT} -w ${C9_WORKSPACE} -l 0.0.0.0 -a ${C9_USER}:${C9_PASS}