#!/bin/bash

# create ssh dir if it does not exist
[ -d "/data/.ssh" ] ||
	mkdir -p "/data/.ssh"

# generate id_rsa if it does not exist
[ -f "/data/.ssh/id_rsa" ] ||
	ssh-keygen -q -t "rsa" -N '' -f "/data/.ssh/id_rsa"

# touch authorized_keys if it does not exist
[ -f "/data/.ssh/authorized_keys" ] ||
	touch "/data/.ssh/authorized_keys"

# set permissions on ssh dir
chown -R root:root "/data/.ssh"
chmod -R 700 "/data/.ssh"

# start multiple processes with supervisor
supervisord -c "/config/supervisord.conf"
