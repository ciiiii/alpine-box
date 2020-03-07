#!/bin/ash
# abort this script when a command fails or a unset variable is used.
set -eu
# echo all the executed commands.
set -x

# replace with tuna mirror
# sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

# Adding the community repository
CURRENT_REPO="$(cat /etc/apk/repositories )"
echo "${CURRENT_REPO}" | sed 's/main/community/g' | tee -a /etc/apk/repositories

# upgrade all packages.
apk upgrade -U --available --no-cache

# Install base packages
apk --no-cache add curl bash bash-completion

# Configure root to use bash
sed -i 's#/ash#/bash#g' /etc/passwd

# add the vagrant user and let it use root permissions without sudo asking for a password.
apk add sudo
adduser -D vagrant
echo 'vagrant:vagrant' | chpasswd
adduser vagrant wheel
echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel

# add support for validating https certificates.
apk add ca-certificates openssl

# install the vagrant public key.
# NB vagrant will replace it on the first run.
install -d -m 700 /home/vagrant/.ssh
# ssh public key
# wget -qO /home/vagrant/.ssh/authorized_keys https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' > /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# install the VirtualBox Guest Additions.
# echo http://mirrors.dotsrc.org/alpine/v3.10/community >> /etc/apk/repositories
apk add -U virtualbox-guest-additions virtualbox-guest-modules-virt
rc-update add virtualbox-guest-additions
echo vboxsf >> /etc/modules
modinfo vboxguest

# install the nfs client to support nfs synced folders in vagrant.
apk add nfs-utils

# disable the DNS reverse lookup on the SSH server. this stops it from
# trying to resolve the client IP address into a DNS domain name, which
# is kinda slow and does not normally work when running inside VB.
sed -i -E 's,#?(UseDNS\s+).+,\1no,' /etc/ssh/sshd_config

# use the up/down arrows to navigate the bash history.
# NB to get these codes, press ctrl+v then the key combination you want.
cat >>/etc/inputrc <<'EOF'
"\e[A": history-search-backward
"\e[B": history-search-forward
set show-all-if-ambiguous on
set completion-ignore-case on
EOF


