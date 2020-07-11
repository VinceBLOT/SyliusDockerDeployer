#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source env vars from .env file
ENV_PATH=$(env ENV_PATH)
SSL_KEYS_PATH=$(env SSL_KEYS_PATH)
LETS_ENCRYPT_EMAIL=$(env LETS_ENCRYPT_EMAIL)
LETS_ENCRYPT_DOMAIN=$(env LETS_ENCRYPT_DOMAIN)
PROXY_PROFILE_NON_SECURE=$(env PROXY_PROFILE_NON_SECURE)
PROXY_PROFILE_SECURE=$(env PROXY_PROFILE_SECURE)

# PRE ##########################################################################

echo "Changing to PROXY_PROFILE_NON_SECURE before issuing certificate, otherwise nginx will refuse to start"
sed -i "s/PROXY_PROFILE=.*/PROXY_PROFILE=${PROXY_PROFILE_NON_SECURE}/g" ${STACK_PATH}/.env

echo "Reset Let's Encrypt folders"
sudo rm -Rf ${STACK_PATH}/docker/volumes/letsencrypt/log/*
sudo rm -Rf ${STACK_PATH}/${SSL_KEYS_PATH}/*

echo "Restart proxy before request to reload new configuration"
cd ${STACK_PATH} && make -f Makefile.prod reload-prod service=proxy

sleep 10

# REQUEST ######################################################################

# Dry run when calling without argument "prod"
EMAIL_ENTRY="--register-unsafely-without-email"
STAGING_ENTRY="--staging"
if [ "${1}" = "prod" ]; then
    EMAIL_ENTRY="--email ${LETS_ENCRYPT_EMAIL} --no-eff-email"
    STAGING_ENTRY=""
fi

echo "Issue request against certbot/certbot"
docker run --rm --name certbot -v "${STACK_PATH}/${SSL_KEYS_PATH}:/etc/letsencrypt" -v "${STACK_PATH}/docker/volumes/letsencrypt/www:/data/letsencrypt" -v "${STACK_PATH}/docker/volumes/letsencrypt/lib:/var/lib/letsencrypt" -v "${STACK_PATH}/docker/volumes/letsencrypt/log:/var/log/letsencrypt" certbot/certbot certonly --webroot ${EMAIL_ENTRY} --agree-tos --webroot-path=/data/letsencrypt ${STAGING_ENTRY} ${LETS_ENCRYPT_DOMAIN}

# Only generate dhparam on production run
if [ "${1}" = "prod" ]; then
    echo "Generating dhparam file"
    openssl dhparam -out ${STACK_PATH}/${SSL_KEYS_PATH}/dhparam.pem 2048
fi

# POST #########################################################################

if [ "${1}" = "prod" ]; then
    echo "Change to PROXY_PROFILE_SECURE after issuing"
    sed -i "s/PROXY_PROFILE=.*/PROXY_PROFILE=${PROXY_PROFILE_SECURE}/g" ${STACK_PATH}/.env
fi

echo "Restart proxy after request to reload new configuration"
cd ${STACK_PATH} && make -f Makefile.prod reload-prod service=proxy

sleep 10

exit 0
