#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

echo "Set logrotate to crontab"
(crontab -l ; echo "@weekly cd ${STACK_PATH} && make -f Makefile.prod run-logrotate") 2> /dev/null | sort - | uniq - | crontab -

exit 0
