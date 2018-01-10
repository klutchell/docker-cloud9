#!/bin/bash

# do some things that couldn't be done until
# the /data dir was mounted

readonly home_dir="/data/home"
readonly ssh_dir="${home_dir}/.ssh"

if [ ! -d /data ]
then
	echo "/data must be mounted to continue!"
	exit 1
fi

# move home dir to /data mount
[ -d "${home_dir}" ] ||
	cp -a "/root" "${home_dir}"

# replace builtin home dir with link
mv /root /root.orig
ln -s "${home_dir}" "/root"
	
# create ssh dir if it does not exist
[ -d "${ssh_dir}" ] ||
	mkdir -p "${ssh_dir}"

# touch authorized_keys if it does not exist
[ -f "${ssh_dir}/authorized_keys" ] ||
	touch "${ssh_dir}/authorized_keys"

# set permissions on ssh dir
chown -R root:root "${ssh_dir}"
chmod -R 700 "${ssh_dir}"

# start multiple processes with supervisor
supervisord -c "/etc/supervisord.conf"
