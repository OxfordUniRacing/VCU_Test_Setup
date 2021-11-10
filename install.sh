#!/bin/sh

set -e

apt update -y
apt upgrade -y
apt install -y telnetd

# python dependencies
pip3 install python-can

cp setup-boot.service /etc/systemd/system/
systemctl daemon-reload
systemctl enable setup-boot.service
