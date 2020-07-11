#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE%/*}" )" >/dev/null 2>&1 && pwd )/deploy/scripts"
. "$DIR/functions.sh"

# Source SSL_KEYS_PATH from .env file
SSL_KEYS_PATH=$(env SSL_KEYS_PATH)

# Reset letsencrypt folders
sudo rm -Rf ${STACK_PATH}/docker/volumes/letsencrypt/log/*

# Issue request against certbot/certbot
docker run --rm --name certbot -v "${STACK_PATH}/${SSL_KEYS_PATH}:/etc/letsencrypt" -v "${STACK_PATH}/docker/volumes/letsencrypt/www:/data/letsencrypt" -v "${STACK_PATH}/docker/volumes/letsencrypt/lib:/var/lib/letsencrypt" -v "${STACK_PATH}/docker/volumes/letsencrypt/log:/var/log/letsencrypt" certbot/certbot renew --webroot --webroot-path=/data/letsencrypt --quiet

# Restart proxy after request to reload new configuration
cd ${STACK_PATH} && make -f Makefile.prod reload-prod service=proxy
sleep 10

exit 0
