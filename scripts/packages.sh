#!bin/bash -eux

echo "==> Enabling EPEL repository"
yum install -y epel-release

echo "==> Installing packages"
yum install -y ansible git vim vim-enhanced
