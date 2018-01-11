#!/bin/bash

# link to custom home dir if it exists
if [ -d "/data/home" ]
then
    mv "/root" "/root.orig"
    ln -s "/data/home" "/root"
fi
