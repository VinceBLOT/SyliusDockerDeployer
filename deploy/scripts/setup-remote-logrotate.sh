#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source STACK_PATH from .env file
REMOTE_STACK_PATH=$(env STACK_PATH)

echo "Setting remote logrotate"
rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod setup-logrotate"

exit 0
