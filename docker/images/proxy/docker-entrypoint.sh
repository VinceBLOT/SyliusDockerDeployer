#!/bin/sh

# CMD ["nginx", "-g", "daemon off;"]
if [[ -z ${1} ]]; then

    # Create snippets folder
    CONFIG_BASE_PATH=/etc/nginx/conf.d
    mkdir -p ${CONFIG_BASE_PATH}/snippets

    # Compile each snippet template to /conf.d/snippets folder
    for SNIPPET in ${CONFIG_BASE_PATH}/template/snippets/*.template; do
        COMPILED_SNIPPET=${CONFIG_BASE_PATH}/snippets/${SNIPPET##*/}
        cp -f "${SNIPPET}" "${COMPILED_SNIPPET}"
        envsubst '$PROXY_DOWNSTREAM_HOST $PROXY_DOWNSTREAM_PORT $SERVER_NAME $APP_PUBLIC_PATH $MAINTENANCE_PUBLIC_PATH $SSL_HEADER_STRICT_TRANSPORT_SECURITY $ALLOW_LIST_DOMAINS' < "${COMPILED_SNIPPET}" > "${COMPILED_SNIPPET%.template}"
        rm ${COMPILED_SNIPPET}
    done

    # Compile main conf file to /conf.d folder
    CONFIG=${CONFIG_BASE_PATH}/template/default.conf.${PROXY_PROFILE}.template
    COMPILED_CONFIG=${CONFIG_BASE_PATH}/default.conf.template
    cp -f "${CONFIG}" "${COMPILED_CONFIG}"
    envsubst '$PROXY_DOWNSTREAM_HOST $PROXY_DOWNSTREAM_PORT $SERVER_NAME $APP_PUBLIC_PATH $MAINTENANCE_PUBLIC_PATH $SSL_HEADER_STRICT_TRANSPORT_SECURITY $ALLOW_LIST_DOMAINS' < "${COMPILED_CONFIG}" > "${COMPILED_CONFIG%.template}"
    rm ${COMPILED_CONFIG}

    exec nginx -g "daemon off;"
fi

exec "$@"
