#!/bin/bash -eux

yum install -y systemd-journal-gateway

# Configure systemd journal permissions permanently (tmpfiles.d)
echo 'm /run/log/journal/%m/system.journal 2755 root systemd-journal - -' > /etc/tmpfiles.d/system-journal.conf

systemctl enable systemd-journal-gatewayd
