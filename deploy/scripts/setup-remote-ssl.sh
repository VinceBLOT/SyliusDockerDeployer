#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source STACK_PATH from .env file
REMOTE_STACK_PATH=$(env STACK_PATH)

# Get target from arguments
TARGET=setup-ssl-dry
if [ "${1}" = "prod" ]; then
    TARGET=setup-ssl
fi

echo "Setting remote ssl"
rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod ${TARGET}"

exit 0
