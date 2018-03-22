#!/bin/bash -eux

echo "==> Configuring settings for vagrant"

SSH_USER=${SSH_USERNAME:-vagrant}
SSH_USER_HOME=${SSH_USER_HOME:-/home/${SSH_USER}}
VAGRANT_INSECURE_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key"

# Add vagrant user (if it doesn't already exist)
if ! id -u "$SSH_USER" >/dev/null 2>&1; then
  echo "==> Creating ${SSH_USER}"
  groupadd -f "$SSH_USER"
  useradd "$SSH_USER" -g "$SSH_USER" -G wheel
  echo "${SSH_USER}"|passwd --stdin "$SSH_USER"
fi

echo "==> Installing Vagrant SSH key"
mkdir -pm 700 "${SSH_USER_HOME}/.ssh"
# https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
echo "${VAGRANT_INSECURE_KEY}" > "$SSH_USER_HOME/.ssh/authorized_keys"
chmod 0600 "${SSH_USER_HOME}/.ssh/authorized_keys"
chown -R "${SSH_USER}:${SSH_USER}" "${SSH_USER_HOME}/.ssh"
chcon -R unconfined_u:object_r:user_home_t:s0 "${SSH_USER_HOME}/.ssh"

echo "==> Recording box generation date"
date > /etc/vagrant_box_build_date

echo "==> Customizing message of the day"
MOTD_FILE="/etc/motd"
PLATFORM_RELEASE=$(sed 's/^.\+ release \([.0-9]\+\).*/\1/' /etc/redhat-release)
PLATFORM_MSG=$(printf 'CentOS %s' "$PLATFORM_RELEASE")
BUILT_MSG=$(printf 'built %s' "$(date +%Y-%m-%d)")
printf '%0.1s' "-"{1..64} > ${MOTD_FILE}
printf '\n' >> ${MOTD_FILE}
printf '%2s%-30s%30s\n' " " "${PLATFORM_MSG}" "${BUILT_MSG}" >> ${MOTD_FILE}
printf '%0.1s' "-"{1..64} >> ${MOTD_FILE}
printf '\n' >> ${MOTD_FILE}
