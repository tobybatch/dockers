#!/bin/bash

DB_READY=1
while [ "$DB_READY" != 0 ]; do
    echo "Waiting for DB, sleeping 5 seconds..."
    sleep 5
    COUNT=$(mysql -u lamp -plamp -h db lamp -e 'select count(*) from users')
    DB_READY="$?"
done
echo "Drupal Ready"
/home/drupal/.composer/vendor/bin/drush -r $(dirname $(find /code -name index.php -maxdepth 3)) rs 0.0.0.0:${DR_PORT}
