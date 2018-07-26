#!/bin/bash -x

sed -i "s/1000:1000/${UID}:${GID}/g" /etc/passwd
sed -i "s/1000/${GID}/g" /etc/group
chown thunderbird:thunderbird -R /home/thunderbird
su - thunderbird -c /usr/bin/thunderbird
