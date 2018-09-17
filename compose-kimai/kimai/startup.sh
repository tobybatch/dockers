#!/bin/bash -e

cd /opt/kimai

count=$(php /usr/local/bin/dbtest.php $DATABASE_URL)
echo "Database has '$count' tables."
if [ "$count" -lt 10 ]; then
    echo "DB not ready, installing..."
    composer install --no-dev --optimize-autoloader
    composer require symfony/web-server-bundle

    bin/console doctrine:schema:create
    # bin/console doctrine:migrations:version --add --all
    bin/console cache:warmup --env=prod
    bin/console cache:warmup --env=dev
    chown -R www-data:www-data var

    if [ ! -z "$ADMIN_USER" ] && [ ! -z "$ADMIN_PASS" ] && [ ! -z "$ADMIN_MAIL" ]; then
        echo "Creating admin user $ADMIN_USER $ADMIN_MAIL $ADMIN_PASS"
        bin/console kimai:create-user $ADMIN_USER $ADMIN_MAIL ROLE_SUPER_ADMIN $ADMIN_PASS
    fi
fi

apachectl -D FOREGROUND
