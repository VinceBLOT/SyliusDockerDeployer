#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

echo "Generating new rsa keypair";

# Source env vars from .env file
SSH_KEYS_PATH=$(env SSH_KEYS_PATH)
REMOTE_IDENTITY=$(env REMOTE_IDENTITY)

# Generate new rsa keypair for remote deployment
if [ ! -f "${STACK_PATH}/${SSH_KEYS_PATH}/${REMOTE_IDENTITY}" ]
then
    ssh-keygen -b 2048 -t rsa -f ${STACK_PATH}/${SSH_KEYS_PATH}/${REMOTE_IDENTITY} -q -N ""
    # 400 (Owner readable only)
    chmod 400 ${STACK_PATH}/${SSH_KEYS_PATH}/${REMOTE_IDENTITY}
fi

echo "Done";

exit 0
