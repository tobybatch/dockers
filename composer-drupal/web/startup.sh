#!/bin/bash

sed -i "s/DR_PORT/${DR_PORT}/g" /etc/nginx/conf.d/default.conf
cat /etc/nginx/conf.d/default.conf
echo "Nginx Ready"
exec nginx -g 'daemon off;'
