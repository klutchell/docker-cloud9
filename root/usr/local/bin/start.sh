#!/bin/bash

readonly HOME="/data/home"
readonly C9_WORKSPACE="/data/workspace"

# create a new home dir from the one in the image
if [ ! -d "${HOME}" ]
then
    cp -a "/root" "${HOME}"
fi

# backup the image home dir and link to the new home dir
mv "/root" "/root.orig"
ln -s "${HOME}" "/root"

# generate ssh key if one does not exist
if [ ! -f "${HOME}/.ssh/id_rsa" ]
then
	ssh-keygen -q -t "rsa" -N '' -f "${HOME}/.ssh/id_rsa" -C "$(id -un)@$(hostname) $(date)"
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
systemctl start smbd nmbd
systemctl start cloud9.service
