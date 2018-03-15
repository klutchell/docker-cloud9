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

# Default to UTC if no TIMEZONE env variable is set
echo "setting time zone to ${TIMEZONE=UTC}"
# This only works on Debian-based images
echo "${TIMEZONE}" > /etc/timezone
dpkg-reconfigure tzdata

# manually start services
systemctl start ssh
systemctl start cloud9.service

