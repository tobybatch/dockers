#!/bin/bash

# Term colours
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

echo -e "${COL_GREEN}+------------------------------------+${COL_RESET}"
echo -e "${COL_GREEN}| Create a new drupal docker cluster |${COL_RESET}"
echo -e "${COL_GREEN}+------------------------------------+${COL_RESET}\n"

TARGET=$1

if [ -z "$TARGET" ]; then
    read -e -p 'Choose target directory: ' TARGET
fi

if [ -d "$TARGET" ]; then
    echo -e "${COL_RED}Target directory exists.  Won't proceed.${COL_RESET}\n"
    exit 1
fi

# Fetch files
mkdir $TARGET
mkdir $TARGET/php
set -x
wget -q -O $TARGET/docker-compose.yml  https://github.com/tobybatch/dockers/raw/develop/composer-drupal/docker-compose.yml 
wget -q -O $TARGET/README.md           https://github.com/tobybatch/dockers/raw/develop/composer-drupal/README.md 
wget -q -O $TARGET/.dockerignore       https://github.com/tobybatch/dockers/raw/develop/composer-drupal/.dockerignore 
wget -q -O $TARGET/php/Dockerfile      https://github.com/tobybatch/dockers/raw/develop/composer-drupal/php/Dockerfile 
wget -q -O $TARGET/php/startup.sh      https://github.com/tobybatch/dockers/raw/develop/composer-drupal/php/startup.sh 
set +x

read -p "Do you want to build the cluster now? [Y/n] " a
if [ "${a^^}" == "Y" ]; then
    cd $TARGET
    docker-compose build
    cd -
fi

pwd
echo "Place a drush archive-dump file in theis folder called archive.tgz and run:"
echo "    cd $TARGET && DR_PORT=8989 docker-compose up"
echo ""
echo "When the tear up is complete you will see:"
echo "  php_1  | PHP 7.1.20 Development Server started at Tue Jul 31 10:56:32 2018"
echo ""
echo -e "Access the new site at ${COL_YELLOW}http://localhost:8989${COL_RESET}"
