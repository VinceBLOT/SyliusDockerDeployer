#!/bin/sh

set -e

if [ -z "${STACK_PATH}" ]; then
    echo "env var STACK_PATH is not defined. You have to run this script via \"make\" target on build server";
    exit 1
fi

echo "Setting filesystem";

# General permissions
chown -R $(whoami):$(whoami) ${STACK_PATH}
chmod -R 0755 ${STACK_PATH}
find ${STACK_PATH} -type f -print0 | xargs -0 chmod 644

# Set scripts executable
find ${STACK_PATH} -type f -name '*.sh' -print0 | xargs -0 chmod 0755

# Data permissions
chmod -R 0777 ${STACK_PATH}/docker/volumes
chmod -R 0777 ${STACK_PATH}/sylius/data

# Create development repo folder
mkdir -p ${STACK_PATH}/sylius/dev

# Set maintenance file
cp ${STACK_PATH}/sylius/data/maintenance/maintenance_on.html.dist \
   ${STACK_PATH}/sylius/data/maintenance/maintenance_on.html

echo "Done";

exit 0
