#!/bin/bash

readonly PERSIST_HOME="/data/home"
readonly C9_WORKSPACE="/data/workspace"

# skip this step if /root is already a link
if [ ! -L "/root" ]
then
	# create a persistent home dir from the one in the image
	[ ! -d "${PERSIST_HOME}" ] && cp -a "/root" "${PERSIST_HOME}"
	
	# backup the image home dir and link to the persistent home dir
	mv "/root" "/root.orig"
	ln -s "${PERSIST_HOME}" "/root"
fi

# generate ssh key if one does not exist
if [ ! -f "${PERSIST_HOME}/.ssh/id_rsa" ]
then
	ssh-keygen -q -t "rsa" -N '' -f "${PERSIST_HOME}/.ssh/id_rsa" -C "$(id -un)@$(hostname) $(date)"
fi

# create c9 workspace if it doesn't exist
if [ ! -d "${C9_WORKSPACE}" ]
then
	mkdir -p "${C9_WORKSPACE}"
fi

# generate host keys
/usr/bin/ssh-keygen -A

# manually start services
systemctl start ssh
systemctl start cloud9.service
