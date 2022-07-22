#!/bin/bash

cd home/ubuntu
git clone https://github.com/trusilov/fast-install-cheatsheet.git
sudo ./fast-install-cheatsheet/scripts/001-install-docker.sh -y

sudo chmod 666 /var/run/docker.sock