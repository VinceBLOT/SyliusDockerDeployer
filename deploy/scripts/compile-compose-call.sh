#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

COMMAND=${1}
ENVIRONMENT=${2}
SERVICE=${3}

# Reset STACK_PATH
LOCAL_STACK_PATH=${STACK_PATH}
STACK_PATH=$(env STACK_PATH)

COMPOSE_PATH=docker/compose

get_enabled_services ()
{
    grep -Ehs "^WITH_" ${LOCAL_STACK_PATH}/.env | while read -r line ; do
        if [ $(echo $line | cut -d '=' -f2) = 1 ]; then
            echo ${line} | sed "s/WITH_/ /g" | sed "s/_/-/g" | cut -d '=' -f1 | tr '[:upper:]' '[:lower:]'
        fi
    done
}

get_compose_files ()
{
    ls ${LOCAL_STACK_PATH}/${COMPOSE_PATH} | while read -r line ; do
        for service in echo $(get_enabled_services); do

            # Check for service.yml
            if [ ${line} = ${service}.yml ] ; then 
                echo "-f ${COMPOSE_PATH}/${line}"; 
            fi

            # Check for service.env.yml
            if echo ${line} | grep -Eq "^${service}.*${ENVIRONMENT}.*yml$"; then
                echo "-f ${COMPOSE_PATH}/${line}"; 
            fi
        done
    done
}

COMPOSE_FILES="-f ${COMPOSE_PATH}/network.yml "$(get_compose_files)

if [ "${COMMAND}" = "build" ]; then
    cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} build --force-rm --pull ${SERVICE}
fi

if [ "${COMMAND}" = "pull" ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib && cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} pull ${SERVICE}
fi

if [ "${COMMAND}" = "up" ]; then
    if [ "${SERVICE}" = "" ]; then
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} up -d --remove-orphans
    else
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} up -d --remove-orphans --no-deps ${SERVICE}
    fi
fi

if [ "${COMMAND}" = "reload" ]; then
    if [ "${SERVICE}" = "" ]; then
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} down
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} up -d --remove-orphans
    else
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} stop -t 60 ${SERVICE}
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} rm --stop --force ${SERVICE}
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} up -d --remove-orphans --no-deps --force-recreate ${SERVICE}
    fi
fi

if [ "${COMMAND}" = "down" ]; then
    if [ "${SERVICE}" = "" ]; then
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} down
    else
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} stop -t 60 ${SERVICE}
        cd ${LOCAL_STACK_PATH} && docker-compose ${COMPOSE_FILES} rm --stop --force ${SERVICE}
    fi
fi

exit 0
