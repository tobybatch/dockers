# Drupal Compose Cluster

This compose bundle tears up a new site from a drush archive dump.

## Quick start

Create a new project and use an ```drush ard``` back up to tear up a new site super fast.  Just choose the location for the new project and download the files:

    export TARGET_DIR=/tmp/foo
    mkdir -p $TARGET_DIR
    wget -O - https://github.com/tobybatch/dockers/archive/v0.0.3.tar.gz | tar -C $TARGET_DIR -zxv --wildcards */composer-drupal --strip-components=2
    $TARGET_DIR/includes/install.sh archive.tgz
    docker-compose --project-directory $TARGET_DIR build
    docker-compose --project-directory $TARGET_DIR up

## Using the installer

The installer used in the previous example unpacks and sets up the drupal for.  Run it with a -h to sse the options.  Basically, it unpacks the archive and locates the sql dump.  It updates the settings.php to match the db settings for the docker cluster and changes the ownership of the files.

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
