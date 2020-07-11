#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source STACK_PATH from .env file
REMOTE_STACK_PATH=$(env STACK_PATH)

if [ "$1" = "on" ]
then
    echo "Setting maintenance mode on"
    rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod set-maintenance-on"
fi

if [ "$1" = "off" ]
then
    echo "Setting maintenance mode off"
    rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod set-maintenance-off"
fi

exit 0
