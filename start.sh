#!/bin/sh

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
fi

wget http://169.254.169.254/latest/meta-data/public-keys/0/openssh-key
wget http://169.254.169.254/latest/user-data

if [ -f openssh-key ]; then
	install -m 700 -d /root/.ssh
	install -m 600 openssh-key /root/.ssh/authorized_keys
fi

if [ -f user-data ]; then
	chmod 755 user-data
	./user-data
fi

exec /sbin/sshd -D

