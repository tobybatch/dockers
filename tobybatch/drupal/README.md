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

We need to grab the set-up site files from the container.

    mkdir -p sites-default && \
    docker run \
        -v $(pwd)/sites-default:/var/tmp/default \
        tobybatch/drupal \
        sudo cp -r /opt/drupal/web/sites/default /var/tmp/

    docker run -d -p 8888:8888 --rm --name drupal -v $(pwd)/sites-default:/opt/drupal/web/sites/default tobybatch/drupal 

