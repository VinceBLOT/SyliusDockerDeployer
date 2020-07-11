#!/bin/sh

set -e

if [ -z "${STACK_PATH}" ]; then
    echo "env var STACK_PATH is not defined. You have to run this script via \"make\" target on build server";
    exit 1
fi

if [ ! -e "${STACK_PATH}/.env" ]; then
    echo "env vars are not compiled yet. You have to run this script via \"make\" target on build server";
    exit 1
fi

env ()
{
    if [ -z "${LOCAL_STACK_PATH}" ]; then 
        LOOKUP_PATH=${STACK_PATH}
    else 
        LOOKUP_PATH=${LOCAL_STACK_PATH}
    fi

    grep -w ${1} ${LOOKUP_PATH}/.env | cut -d '=' -f2
}

# Source env vars from .env file
REMOTE_IDENTITY=$(env REMOTE_IDENTITY)
HOST_IP=$(env HOST_IP)
REMOTE_USER=$(env REMOTE_USER)
SSH_KEYS_PATH=$(env SSH_KEYS_PATH)
REMOTE_STACK_PATH=$(env STACK_PATH)

# ssh wrapper
rssh ()
{
ssh -i ${STACK_PATH}/${SSH_KEYS_PATH}/${REMOTE_IDENTITY} ${REMOTE_USER}@${HOST_IP} ${1}
}

# scp wrapper
rscp ()
{
scp -i ${STACK_PATH}/${SSH_KEYS_PATH}/${REMOTE_IDENTITY} -r ${STACK_PATH}/${1} ${REMOTE_USER}@${HOST_IP}:${REMOTE_STACK_PATH}/${1}
}
