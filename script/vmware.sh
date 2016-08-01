#!/bin/bash -eux

if [[ $PACKER_BUILDER_TYPE =~ vmware ]]; then
    echo "==> Installing VMware Tools"
    yum install -y open-vm-tools
    mkdir /mnt/hgfs
fi
