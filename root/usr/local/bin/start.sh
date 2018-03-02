#!/bin/bash

# create persistent ssh dir if it doesn't exist
if [ ! -d "/data/.ssh" ]
then
	mkdir -p "/data/.ssh"
fi

# link to persistent ssh dir
if [ ! -L "/root/.ssh" ]
then
	ln -s "/data/.ssh" "/root/.ssh"
fi

# generate ssh key if one does not exist
if [ ! -f "/data/.ssh/id_rsa" ]
then
	ssh-keygen -q -t "rsa" -N '' -f "/data/.ssh/id_rsa" -C "$(id -un)@$(hostname) $(date)"
fi

# set permissions on ssh dir
chown -R root:root "/data/.ssh"
chmod -R 700 "/data/.ssh"

# generate ssh host keys
/usr/bin/ssh-keygen -A

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

# manually start services
systemctl start ssh
systemctl start docker
systemctl start cloud9.service

