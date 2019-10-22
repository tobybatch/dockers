#!/bin/bash

sed -i "s#BLOCKLIST_URL#${BLOCKLIST_URL}#g" /etc/transmission-daemon/settings.json

transmission-daemon \
    --foreground \
    --rpc-bind-address 0.0.0.0 \
    --blocklist \
    --username ${RPC_USERNAME} \
    --password ${RPC_PASSWORD} \
    --download-dir /download \
    --encryption-required
