# Docker

## Docker compose

You can enable and disable docker services via env vars in `env/docker/services`. To do so all service definitions must have their own docker compose file in `/docker/compose`. Taking `nignx` as an example, `/docker/compose/nginx.yml` can be enabled by setting `WITH_NGINX=1`. In this case it will be enabled in all stages.

If you want to define more specific configuration to certain stage, you can define different compose files for every stage, like `nginx.dev.yml` or even `nginx.dev.test.yml` if you want to apply that configuration in both `dev` and `test` stages. 

## Docker images

### Stock images

Docker images are defined in `env/docker/images`. To update an stock image you only have to change its definition:

```bash
MYSQL_IMAGE=mysql:5.7.30
```

And then run `make pull-[stage]` to pull the new image.

### Custom images

With custom images you have to define the stock image to use as a base image:

```bash
PHP_BASE_IMAGE=php:7.4.6-fpm-alpine3.11
```

In this case is strongly advised to build your images on local, upload them to a private registry and pull them from remote. To do so, you have to create an [override file](env-vars.md#organizing-env-vars-files) and set your custom image name there:

```bash
# env/docker/images.override
# Custom image location for google cloud docker registry
PHP_IMAGE=eu.gcr.io/name-123456/custom-build-php-dev:7.4.6-fpm-alpine3.11
```

Once you have done this, you have to build it with `make build-[stage]`.

### Container registry

When you've built your images, it is advised to upload them to [Docker container registry](gcp/docker-registry.md).

## Docker services

* [Nginx SSL termination proxy](services/proxy.md)
* [Varnish](services/varnish.md)
* [Nginx](services/nginx.md)
* [PHP](services/php.md)
* [Mysql](services/mysql.md)
* [Elasticsearch](services/elasticsearch.md)
* [Kibana](services/kibana.md)
* [Mailhog](services/mailhog.md)
* [Adminer](services/adminer.md)
* [Chrome headless](services/chrome-headless.md)
* [Selenium Chrome](services/selenium-chrome.md)
* [Memcached](services/memcached.md)
