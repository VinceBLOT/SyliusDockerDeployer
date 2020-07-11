#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

echo "Set database backup to crontab"
(crontab -l ; echo "@hourly cd ${STACK_PATH} && make -f Makefile.prod run-database-backup") 2> /dev/null | sort - | uniq - | crontab -

exit 0
