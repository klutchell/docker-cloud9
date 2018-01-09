#!/bin/bash

readonly c9_workspace="/data/workspace"
readonly ssh_config_dir="/data/.ssh"

# create ssh config dir if it does not exist
mkdir -p "${ssh_config_dir}" 2>/dev/null || true

# generate id_rsa if it does not exist
if [ ! -f "${ssh_config_dir}/id_rsa" ]
then
	ssh-keygen -q -t "rsa" -N '' -f "${ssh_config_dir}/id_rsa"
fi

# generate authorized_keys if it does not exist
if [ ! -f "${ssh_config_dir}/authorized_keys" ]
then
	touch "${ssh_config_dir}/authorized_keys"
fi

# set permissions on ssh config dir
chown -R abc:abc "${ssh_config_dir}"
chmod -R 700 "${ssh_config_dir}"

if [ ! -d "${c9_workspace}" ]
then
	mkdir -p "${c9_workspace}"
	chown -R abc:abc "${c9_workspace}"
fi

# start multiple processes with supervisor
supervisord -c /config/supervisord.conf
