#!/bin/bash

# create c9 workspace if it doesn't exist
if [ ! -d "/data/workspace" ]
then
	mkdir -p "/data/workspace"
fi

# create docker root if it doesn't exist
if [ ! -d "/data/docker" ]
then
	mkdir -p "/data/docker"
fi

# generate ssh host keys
/usr/bin/ssh-keygen -A

# manually start services
systemctl start ssh
systemctl start cloud9.service
systemctl start docker

