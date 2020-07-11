# PHP

## Images

To support all needed tools in development and at the same time maintain a lightweight image for production, two images are used. They are based on stock PHP image.

Development image `Dockerfile_dev` is almost identical to production one `Dockerfile_prod`, with the addition of `Yarn` and `Xdebug`.

## Configuration

You can see all configuration options in `env/docker/php`.

## Xdebug

Xdebug is available in development stages, you can enable it by:

```bash
# env/docker/services
WITH_XDEBUG=1

# env/docker/php
PHP_XDEBUG_ENABLE=1

# Must be the same subnet as in env/docker/network NETWORK_SUBNET
PHP_XDEBUG_HOST_IP=172.${NETWORK_SUBNET}.0.1
PHP_XDEBUG_REMOTE_PORT=9000
```
