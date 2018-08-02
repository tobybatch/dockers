#!/bin/bash

echo "Drupal Ready"
/home/drupal/.composer/vendor/bin/drush -r $(dirname $(find /code -name index.php -maxdepth 3)) rs 0.0.0.0:${DR_PORT}
