#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source REMOTE_STACK_PATH from .env file
REMOTE_STACK_PATH=$(env REMOTE_STACK_PATH)

echo "Running remote database backup"
rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod run-database-backup"

exit 0
