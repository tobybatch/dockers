#!/bin/bash

if [ -f /tmp/archive.tgz ]; then
    echo -n "Unpacking archive..."
    tar -C /tmp -zx -f /tmp/archive.tgz
    echo " Done."

    # get root, this is not ideal but there should only ever be two dirs, ./ and the site dir
    SITEDIR=$(find /tmp -maxdepth 1 -type d |sort | tail -n 1)
    # mv files to web root
    echo -n "Moving files from ${SITEDIR} to /code..."

    mv ${SITEDIR}/* ${SITEDIR}/.???* /code
    echo " Done."

    # get db details this assumes it the default site

    # create db details
    # import db
fi

bash
