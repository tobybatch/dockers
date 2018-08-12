#!/bin/bash

httrack --verbose "$REMOTE_HOST" -O "/usr/share/nginx/html" "$FILTER"
nginx -g "daemon off;"

