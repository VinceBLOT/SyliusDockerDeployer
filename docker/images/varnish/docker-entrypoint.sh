#!/bin/sh

# CMD ["varnish"]
if [ "$1" = 'varnish' ]; then

    # Compile config file template
    cp -f /etc/varnish/template/custom.vcl.${VARNISH_PROFILE}.template /etc/varnish/custom.vcl.template
    envsubst '$NGINX_PORT $SERVER_NAME' < /etc/varnish/custom.vcl.template > /etc/varnish/custom.vcl

    exec varnishd -F -a :${VARNISH_PORT} -f /etc/varnish/custom.vcl -s ${VARNISH_STORAGE} -p default_ttl=${VARNISH_DEFAULT_TTL} -p default_grace=${VARNISH_DEFAULT_GRACE}
fi

exec "$@"
