#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source env vars from .env file
BUILD_ON_REMOTE=$(env BUILD_ON_REMOTE)
ENV_PATH=$(env ENV_PATH)
REMOTE_STACK_PATH=$(env STACK_PATH)
STACK_REPO=$(env STACK_REPO)
USE_SUDO=$(env USE_SUDO)

# Use sudo on remote filesystem operations
SUDO=
if [ "${USE_SUDO}" = "1" ]; then
    SUDO="sudo "
fi

# SSH ##########################################################################

# Remove old stack if requested
if [ "${1}" = "override" ]; then
    echo "Removing stack folder"
    rssh "${SUDO}rm -rf ${REMOTE_STACK_PATH}"
    echo "Removing docker containers, images and volumes"
    rssh 'docker kill $(docker ps -q) >/dev/null 2>&1 || true'
    rssh 'docker rm -f $(docker ps -aq) >/dev/null 2>&1 || true'
    rssh 'docker rmi -f $(docker images -q) >/dev/null 2>&1 || true'
    rssh 'docker system prune --all --force --volumes >/dev/null 2>&1 || true'
fi

echo "Creating stack folder"
rssh "mkdir -p ${REMOTE_STACK_PATH}"
echo "Cloning stack repo"
rssh "git clone ${STACK_REPO} ${REMOTE_STACK_PATH} -q"
echo "Setup filesystem"
rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod setup-filesystem"
echo "Setup cronfile"
rssh "crontab -r || true"
rssh "touch ${REMOTE_STACK_PATH}/crontab"
rssh "crontab ${REMOTE_STACK_PATH}/crontab"
echo "Setup .env file"
rssh "cd ${REMOTE_STACK_PATH} && ${SUDO}rm -rf ${ENV_PATH}"
rscp .env

# LOCAL MAKE ###################################################################

if [ "${BUILD_ON_REMOTE}" = "1" ]; then
    echo "Building docker images"
    rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod build-prod"
fi
echo "Pulling docker images"
rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod pull-prod"
echo "Up docker containers"
rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod up-prod"
echo "Cleanup docker artifacts"
rssh "cd ${REMOTE_STACK_PATH} && make -f Makefile.prod cleanup-prod"

exit 0
