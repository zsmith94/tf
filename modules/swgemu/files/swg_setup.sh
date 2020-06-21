#!/bin/bash

mkdir -p /etc/swgemu
cd /etc/swgemu
git clone http://review.swgemu.com/Core3
cd Core3/MMOCoreORB/
make -j8



