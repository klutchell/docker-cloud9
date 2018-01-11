#!/bin/bash

# link to custom home dir if it exists
if [ -d "/data/home" ]
then
    echo "using persistent home directory: /data/home"
    mv "/root" "/root.orig"
    ln -s "/data/home" "/root"
else
    echo "using image home directory: /root"
fi