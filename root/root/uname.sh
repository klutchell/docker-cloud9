#!/bin/sh
/bin/uname.orig $* | sed "s/armv8l/armv7l/"