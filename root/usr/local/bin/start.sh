#!/bin/bash

# create custom home dir if one does not exist
if [ ! -d "${HOME_DIR}" ]
then
	cp -a "/root" "${HOME_DIR}" || exit 1
fi

# replace builtin home dir with link
mv /root /root.orig
ln -s "${HOME_DIR}" "/root"

# start multiple processes with supervisor
supervisord -c ${SUPERVISOR_CONFIG}
