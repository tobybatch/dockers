#!/bin/bash

SETTINGS=$(find /code -name settings.php)
echo "SETTINGS=$SETTINGS"
if [ ! -z "$SETTINGS" ]; then
    echo "Site already exists, skipping file copy."
    echo "If you want to reset the files then remove at least the file:"
    echo "    code/sites/default/settings.php"
else
    echo -n "Unpacking archive..."
    tar -C /tmp -zx -f /tmp/archive.tgz
    echo " Done."

    # get root, this is not ideal but there should only ever be two dirs, ./ and the site dir
    SITEDIR=$(find /tmp -maxdepth 1 -type d |sort | tail -n 1)
    # mv files to web root
    echo -n "Moving files from ${SITEDIR} to /code..."

    cp -r ${SITEDIR}/* ${SITEDIR}/.???* /code
    echo " Done."

    # append our db details at the end of settings.php
    # this should override the existing seetings in the archive.
    SETTINGS=$(find /code -name settings.php)
    cat <<EOF>>$SETTINGS
        \$databases = array (
            'default' => array (
                'default' => array (
                    'database' => '$DBNAME',
                    'username' => '$DBUSER',
                    'password' => '$DBPASS',
                    'host' => '$DBHOST',
                    'port' => '',
                    'driver' => 'mysql',
                    'prefix' => '',
                ),
            ),
        );
EOF
    # import db
    drush sqlc < /tmp/*.sql
fi

SETTINGS=$(find /code -name settings.php)
if [ -z "$SETTINGS" ]; then
    # We have no drupal !
    echo "No drupal found, did you provide a valid archive.tgz?<br />" > index.html
    echo "<a href='https://github.com/tobybatch/dockers/tree/develop/composer-drupal'>README</a>" >> index.html
    php -S 0.0.0.0:${DR_PORT}
else
    # Fix permissions
    SETTINGS=$(find /code -name settings.php)
    setfacl -dR -m u:"www-data":rwX -m u:root:rwX $(dirname $SETTINGS)/files
    setfacl -R -m u:"www-data":rwX -m u:root:rwX $(dirname $SETTINGS)/files

    echo "Drupal Ready"
    drush rs 0.0.0.0:${DR_PORT}
fi
