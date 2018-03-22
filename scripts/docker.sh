#!/bin/bash -eux

yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum install -y docker-ce
systemctl enable docker
groupadd -f docker
usermod -a -G docker vagrant
