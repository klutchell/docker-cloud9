#!/bin/bash

# move home directory and put link in original location
if [ ! -d "/data/abc" ]
then
	mv "/home/abc" "/data/abc"
	ln -s "/data/abc" "/home/abc"
fi

# create ssh dir if it does not exist
if [ ! -d "/data/abc/.ssh" ]
then
	mkdir -p "/data/abc/.ssh"
fi

# generate id_rsa if it does not exist
if [ ! -f "/data/abc/.ssh/id_rsa" ]
then
	ssh-keygen -q -t "rsa" -N '' -f "/data/abc/.ssh/id_rsa"
fi

# touch authorized_keys if it does not exist
if [ ! -f "/data/abc/.ssh/authorized_keys" ]
then
	touch "/data/abc/.ssh/authorized_keys"
fi

# set permissions on ssh dir
chown -R abc:abc "/data/abc/.ssh"
chmod -R 700 "/data/abc/.ssh"

# start multiple processes with supervisor
supervisord -c /config/supervisord.conf
