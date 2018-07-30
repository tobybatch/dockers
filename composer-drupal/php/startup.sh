#!/bin/bash

if [ -f /tmp/archive.tgz ]; then
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
  'default' =>
  array (
    'default' =>
    array (
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

# No harm doing this every time
setfacl -dR -m u:"www-data":rwX -m u:root:rwX $(dirname $SETTINGS)/files
setfacl -R -m u:"www-data":rwX -m u:root:rwX $(dirname $SETTINGS)/files

php-fpm
