PHP Drupal
==========

Takes the tobybatch/php and adds drush

## Build

    docker build --rm -t tobybatch/drupal .

Set the UID 1 account details

    docker build --rm -t tobybatch/drupal:custom --build-arg ACCOUNT_NAME=admin --build-arg ACCOUNT_PASS=changethis --build-arg ACCOUNT_MAIL=foo@example.com .

## Run it


### Skunk

    docker run -d -p 8888:8888 --rm --name drupal tobybatch/drupal

### Persist the DB/files/modules

    docker run -d -p 8888:8888 --rm --name drupal -v $(pwd)/sites-default:/opt/drupal/sites/default tobybatch/drupal
