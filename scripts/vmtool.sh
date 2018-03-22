#!/bin/bash -eux

echo "==> Installing VirtualBox guest additions"

yum -y install "kernel-headers-$(uname -r)" "kernel-devel-$(uname -r)" elfutils-libelf-devel gcc make perl

SSH_USER=${SSH_USERNAME:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}
VBOX_VERSION=$(cat "$SSH_USER_HOME/.vbox_version")

mount -o loop "$SSH_USER_HOME/VBoxGuestAdditions_$VBOX_VERSION.iso" /mnt
sh /mnt/VBoxLinuxAdditions.run --nox11
umount /mnt
rm -rf "$SSH_USER_HOME/VBoxGuestAdditions_$VBOX_VERSION.iso"
rm -f "$SSH_USER_HOME/.vbox_version"

echo "==> Removing packages needed for building guest tools"
yum -y remove gcc cpp libmpc mpfr kernel-devel kernel-headers perl elfutils-libelf-devel
