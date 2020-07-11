#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source MAINTENANCE_PATH from .env file
MAINTENANCE_PATH=$(env MAINTENANCE_PATH)

if [ "$1" = "on" ]
then
    cd ${MAINTENANCE_PATH} && if [ -f maintenance_off.html ]; then mv maintenance_off.html maintenance_on.html && echo done; fi
fi

if [ "$1" = "off" ]
then
    cd ${MAINTENANCE_PATH} && if [ -f maintenance_on.html ]; then mv maintenance_on.html maintenance_off.html && echo done; fi
fi

exit 0
