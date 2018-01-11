#!/bin/bash

# create custom home dir if one does not exist
[ ! -d "/data/home" ] || cp -a "/root" "/data/home"

# replace builtin home dir with link
mv "/root" "/root.orig"
ln -s "/data/home" "/root"

# start multiple processes with supervisor
supervisord -c "/config/supervisord.conf"
