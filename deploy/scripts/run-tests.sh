#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Reset STACK_PATH
LOCAL_STACK_PATH=${STACK_PATH}
STACK_PATH=$(env STACK_PATH)

# Get env vars
APP_CURRENT_RELEASE_PATH=$(env APP_CURRENT_RELEASE_PATH)

echo "Running tests"

code=0

echo "Running phpspec.."
docker exec --workdir ${STACK_PATH}/${APP_CURRENT_RELEASE_PATH} php sh -c "vendor/bin/phpspec run --no-interaction -f dot" || code=$?

if [ ${code} = 1 ]; then
    exit 1
fi

echo "Testing (Behat - brand new, regular scenarios; ~@javascript && ~@todo && ~@cli)"
docker exec --workdir ${STACK_PATH}/${APP_CURRENT_RELEASE_PATH} php sh -c "vendor/bin/behat --strict --no-interaction -vvv -f progress --tags=\"~@javascript && ~@todo && ~@cli\"" || code=$?
if [ ${code} = 1 ]; then
    docker exec --workdir ${STACK_PATH}/${APP_CURRENT_RELEASE_PATH} php sh -c "vendor/bin/behat --strict --no-interaction -vvv -f progress --tags=\"~@javascript && ~@todo && ~@cli\" --rerun" ; code=$?
fi

if [ ${code} = 1 ]; then
    exit 1
fi

echo "Testing (Behat - brand new, javascript scenarios; @javascript && ~@todo && ~@cli)"
docker exec --workdir ${STACK_PATH}/${APP_CURRENT_RELEASE_PATH} php sh -c "vendor/bin/behat --strict --no-interaction -vvv -f progress --tags=\"@javascript && ~@todo && ~@cli\"" || code=$?
if [ ${code} = 1 ]; then
    docker exec --workdir ${STACK_PATH}/${APP_CURRENT_RELEASE_PATH} php sh -c "vendor/bin/behat --strict --no-interaction -vvv -f progress --tags=\"@javascript && ~@todo && ~@cli\" --rerun" ; code=$?
fi
if [ ${code} = 1 ]; then
    docker exec --workdir ${STACK_PATH}/${APP_CURRENT_RELEASE_PATH} php sh -c "vendor/bin/behat --strict --no-interaction -vvv -f progress --tags=\"@javascript && ~@todo && ~@cli\" --rerun" ; code=$?
fi

if [ ${code} = 1 ]; then
    exit 1
fi

# Reset STACK_PATH
STACK_PATH=${LOCAL_STACK_PATH}

exit 0
