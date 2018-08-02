# Drupal Compose Cluster

This compose bundle tears up a new site from a drush archive dump.

## Quick start

Create a new project and use an ```drush ard``` back up to tear up a new site super fast.  Just choose the location for the new project and download the files:

    export TARGET_DIR=/tmp/foo
    mkdir -p $TARGET_DIR
    wget -O - https://github.com/tobybatch/dockers/archive/v0.0.1.tar.gz | tar -C $TARGET_DIR -zxv --wildcards */composer-drupal --strip-components=2

    export TARGET_DIR=/tmp/foo && mkdir -p $TARGET_DIR && wget -O - https://github.com/tobybatch/dockers/archive/v0.0.1.tar.gz | tar -C $TARGET_DIR -zxv --wildcards */composer-drupal --strip-components=2 && $TARGET_DIR/includes/install.sh archive.tgz && docker-compose build -f $TARGET_DIR/docker-compose.yml

Change directory into that folder, and run the installer.  You will at least need to know thw location of your archive.tgz.  Then the command with a -h to see the options ```./includes/install.sh -h``` or just pass it the archive location.

    cd $TARGET_DIR
    ./includes/install.sh archive.tgz

Then build and run the docker-compose

    docker-compose build && docker-compose up

## Stopping and starting

Once the images have been built yoo can stop and start them with:

    docker compose up

And to stop them

    [ctrl]-c

## Reset the bundle

Destroy the dockers

    docker-compose rm

The files in code will be overwritten and the db file re-loaded.

To fully reset the bundle you can remove the persisted files:

    docker-compose rm && rm -rf code mysql-datadir

Then

    docker-compose up

## Archive structure

This was written to take the output from ```drush ard``` which has been removed in drush 9.  To create an archive by hand you want this structure:

    |
    +- some-dump.sql
    +- some-folder-with-a-drupal-in-it

You can create this using this from the directory holding the drupal:

    export DRUPAL_DIR_NAME=foo
    drush -r $DRUPAL_DIR_NAME sql-dump --ordered-dump --structure-tables-key=common --result-file=../$DRUPAL_DIR_NAME.sql && tar zcf archive.tgz $DRUPAL_DIR_NAME
