#!/bin/bash

sed -i "s/1000:1000/${UID}:${GID}/g" /etc/passwd
sed -i "s/1000/${GID}/g" /etc/group
chown developer:developer -R /home/developer
su - developer -c "/usr/local/netbeans-8.2/bin/netbeans --fontsize ${FONT_SIZE}"
