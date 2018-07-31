# Drupal Compose Cluster

This compose bundle tears up a new site from a drush archive dump.

## Quick start

Just place the archive dump in the root folder, it must be named archive.tgz.

When the docker compose is started this archive will be unpacked in the folder code in the root folder.  The DB will be imported into the mysql db.  The SQL files persist in the folder mysql-datadir in the root folder.

Then run docker compose build, docker compose up

    docker-compose build && docker compose up

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
