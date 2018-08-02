#!/bin/bash

# Some globals
ROOT_DIR=$(realpath $(dirname $0)/..)

CODE_PATH=$(realpath $ROOT_DIR/code)
SQL_PATH=$(realpath $ROOT_DIR/sql)
TMP_PATH=$(realpath $ROOT_DIR/tmp)
USAGE="$(basename $0) [-f] [archive.tgz]"

# Prevent rm goofs while testing
alias rm=echo

function main {
    checkRequirements
    termColours
    setupVars "$@"

    source $ROOT_DIR/.env 

    echo -e "${COL_GREEN}+--------------------+${COL_RESET}"
    echo -e "${COL_GREEN}| Drupal Stack Setup |${COL_RESET}"
    echo -e "${COL_GREEN}+------------------+--${COL_RESET}\n"

    # -F - clear existing data is true, remove code and sql folders.
    if [ ! -z "$CLEAR" ]; then
        # Fail if we can't delete the folders
        echo "Clearing exisiting files."
        set -e
        rm -rf $SQL_PATH $CODE_PATH
        set +e
    else
        echo "Preserving exsiting files."
    fi

    if [ -z "$FORCE" ]; then
        checkForeExistingData
    else
        echo "Allowing file overwrites."
    fi

    # Prepare locations
    mkdir -p $SQL_PATH $CODE_PATH

    # Unpack the archive unless -s is specified.
    if [ -z "$SKIPUNPACK" ]; then
        # If no file was passed ask for it
        while [ ! -f "$ARCHIVE" ]; do
            read -e -p "Specify the archive ithat should be installed into this cluster: " ARCHIVE
        done
        unpack
    fi

    echo "Chowning files to you.  We may need your sudo password."
    sudo chown -R $(id -u):$(id -g) ${CODE_PATH}

    # Locate the first index.php, this will be the site root.
    INDEX=$(find $CODE_PATH -maxdepth 3 -name index.php)
    # Locate the settings file, currently we don't support multisites.
    SETTINGS=$(find $CODE_PATH -name settings.php)

    echo "Updating DB settings in drupal config."
    php $ROOT_DIR/includes/fixsettings.php $SETTINGS $DBNAME $DBUSER $DBPASS $DBHOST > $SETTINGS.new
    cp $SETTINGS $SETTINGS.orig
    mv $SETTINGS.new $SETTINGS
}

# Helper functions

function setupVars {
    source $ROOT_DIR/.env

    # Parse args
    while getopts "fFhs" options; do
        case $options in
            f) FORCE=1;;
            F) CLEAR=1;;
            s) SKIPUNPACK=1;;
            h) usage; exit;;
        esac
    done

    shift $((OPTIND-1))
    # If a parameter is passed it should br the archive file.
    ARCHIVE="$1"
}

function checkRequirements {
    # Check required commands
    type realpath > /dev/null
    if [ "$?" != 0 ]; then
        echo Required command realpath not found
        echo Use "sudo apt install realpath"
        exit 1
    fi
}

function checkForeExistingData {
    # Check for existing data.
    if [ -d "$SQL_PATH" ] && [ "$(ls $SQL_PATH|wc -l)" -gt 0 ]; then
        echo -e "${COL_RED}SQL file already exists. Aborting.${COL_RESET}\n"
        exit 1
    fi
    echo "SQL file does not exist"

    if [ -d "$CODE_PATH" ] && [ "$(ls $CODE_PATH|wc -l)" -gt 0 ]; then
        echo -e "${COL_RED}Code directory not empty. Aborting.${COL_RESET}\n"
        exit 2
    fi
    echo "Code folder is empty or non-existent"
}

function termColours {
# Term colours
    export ESC_SEQ="\x1b["
    export COL_RESET=$ESC_SEQ"39;49;00m"
    export COL_RED=$ESC_SEQ"31;01m"
    export COL_GREEN=$ESC_SEQ"32;01m"
    export COL_YELLOW=$ESC_SEQ"33;01m"
    export COL_BLUE=$ESC_SEQ"34;01m"
    export COL_MAGENTA=$ESC_SEQ"35;01m"
    export COL_CYAN=$ESC_SEQ"36;01m"
}

function unpack {
    echo -n "Unpacking $ARCHIVE..."
    tar -zx --strip-components=1 -C $CODE_PATH -f $ARCHIVE
    tar -zx -C $SQL_PATH -f $ARCHIVE --wildcards "*.sql"
    find $SQL_PATH/* -type d -exec rm -rf {} +
    echo -e " Done."
}

function usage {
    echo $USAGE
    cat <<EOF
Set up the current directory to tear up a Drupla install from a drush ard
dump file.  The script is interactive unless required data is passed in.

archive.tgz
    If peovided use this archive.
-f  Force all changes, overwrite existing files and folder.
-F  Clear exsisting file. Remove code and sql directories.
-s  Skip unpacking the archive, used mainly while testing.
-h  Show this message.
EOF
}

main "$@"
