#!/bin/bash

httrack "$REMOTE_HOST" -O "/usr/share/nginx/html" "$FILTER"
nginx -g "daemon off;"

