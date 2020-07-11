#!/bin/sh

set -e

if [ -z "${STACK_PATH}" ]; then
    echo "env var STACK_PATH is not defined. You have to run this script via \"make\" target on build server";
    exit 1
fi

# Precedence:
# env/folder/service.env[.env].override
# env/folder/service.override
# env/folder/service.env[.env]
# env/folder/service

ENVIRONMENT=${1}

# Reset STACK_PATH
LOCAL_STACK_PATH=${STACK_PATH}

ENV_PATH=${LOCAL_STACK_PATH}/env

# Call with: $(get_folders)
get_folders ()
{
    FOLDERS=$(cd ${ENV_PATH} && ls ${ENV_PATH} | grep -v '\.')
    for FOLDER in ${FOLDERS}
    do
        echo ${FOLDER}
    done
}

# Call with: $(get_files ${FOLDER})
get_files ()
{
    FOLDER=${1}
    ls ${ENV_PATH}/${FOLDER}/ | while read -r LINE ; do
        echo ${LINE}
    done
}

# Call with: $(get_services ${FOLDER})
get_services ()
{
    FOLDER=${1}
    ls ${ENV_PATH}/${FOLDER}/ | while read -r LINE ; do
        echo ${LINE} | cut -d '.' -f1
    done | sort -t= -u -k1,1
}

# Reset tmp files
>${LOCAL_STACK_PATH}/.env.tmp
>${LOCAL_STACK_PATH}/.env.firstpass

# env/folder/service.env[.env].override
for FOLDER in $(get_folders); do
    FOLDER_PATH=${ENV_PATH}/${FOLDER}
    for FILE in $(get_files ${FOLDER}); do
        FILE_PATH=${FOLDER_PATH}/${FILE}
        for SERVICE in $(get_services ${FOLDER}); do
            if echo ${FILE_PATH} | grep -Eq "^${FOLDER_PATH}/${SERVICE}.*${ENVIRONMENT}.*override$"; then
                grep -Ehsv "^#|^$$" ${FILE_PATH} >>${LOCAL_STACK_PATH}/.env.tmp || true
            fi
        done
    done
done

# env/folder/service.override
for FOLDER in $(get_folders); do
    FOLDER_PATH=${ENV_PATH}/${FOLDER}
    for FILE in $(get_files ${FOLDER}); do
        FILE_PATH=${FOLDER_PATH}/${FILE}
        for SERVICE in $(get_services ${FOLDER}); do
            if [ ${FILE_PATH} = ${FOLDER_PATH}/${SERVICE}.override ] ; then 
                grep -Ehsv "^#|^$$" ${FILE_PATH} >>${LOCAL_STACK_PATH}/.env.tmp || true
            fi
        done
    done
done

# env/folder/service.env[.env]
for FOLDER in $(get_folders); do
    FOLDER_PATH=${ENV_PATH}/${FOLDER}
    for FILE in $(get_files ${FOLDER}); do
        FILE_PATH=${FOLDER_PATH}/${FILE}
        for SERVICE in $(get_services ${FOLDER}); do
            if echo ${FILE_PATH} | grep -Eq "^${FOLDER_PATH}/${SERVICE}.*${ENVIRONMENT}.*$"; then
                if echo ${FILE_PATH} | grep -Evq "override$"; then
                    grep -Ehsv "^#|^$$" ${FILE_PATH} >>${LOCAL_STACK_PATH}/.env.tmp || true
                fi
            fi
        done
    done
done

# env/folder/service
for FOLDER in $(get_folders); do
    FOLDER_PATH=${ENV_PATH}/${FOLDER}
    for FILE in $(get_files ${FOLDER}); do
        FILE_PATH=${FOLDER_PATH}/${FILE}
        for SERVICE in $(get_services ${FOLDER}); do
            if [ ${FILE_PATH} = ${FOLDER_PATH}/${SERVICE} ] ; then 
                grep -Ehsv "^#|^$$" ${FILE_PATH} >>${LOCAL_STACK_PATH}/.env.tmp || true
            fi
        done
    done
done

# Sort and remove duplicates (Keeping the highest precedence entries)
cat ${LOCAL_STACK_PATH}/.env.tmp | sort -t= -u -k1,1 >${LOCAL_STACK_PATH}/.env.firstpass

# Variable substitution
FIRSTPASS_FILE=${LOCAL_STACK_PATH}/.env.firstpass
sed -i "s/ /__SPACE__/g" ${FIRSTPASS_FILE}
while IFS= read LINE; do
    (. ${FIRSTPASS_FILE} ; export $(cut -d= -f1 ${FIRSTPASS_FILE}) ; echo ${LINE} | envsubst)
done <${FIRSTPASS_FILE} >${LOCAL_STACK_PATH}/.env
sed -i "s/__SPACE__/ /g" ${LOCAL_STACK_PATH}/.env

# Cleanup
rm ${LOCAL_STACK_PATH}/.env.tmp
rm ${LOCAL_STACK_PATH}/.env.firstpass

# Reset STACK_PATH
STACK_PATH=${LOCAL_STACK_PATH}

exit 0
