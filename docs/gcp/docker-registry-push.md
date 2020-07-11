# Push to Docker registry

## Build

### Tag pattern

To push any local image to Container Registry, you need to build and tag it with the registry name. The name pattern is as follows:

```bash
# on env/docker/images
# [HOSTNAME]/[PROJECT-ID]/[IMAGE]:[TAG]
eu.gcr.io/project-123456/custom-build-php-prod:7.4.6-fpm-alpine3.11
```

### Build

For every service, you need to define at least two env vars (in `env/docker/images`) to store base image (`SERVICE_BASE_IMAGE`), and target image name (`SERVICE_IMAGE`). 

Also, at least one `Dockerfile` must be present in such service folder. In `/docker/compose/service.yml` we need the following:

```bash
  build:
    context: './docker/images/service'
    dockerfile: 'Dockerfile'
    args:
      base_image: ${SERVICE_BASE_IMAGE}
  image: ${SERVICE_IMAGE}
```

To build the image you only have to call `make build-[stage] service=[service]`.

## Push

If everything is ok, copy the name of the new image and push it to the registry. To push an image it need to be tagged beforehand, but in this case `docker-compose` take care of it after a successful build:

```bash
Successfully tagged eu.gcr.io/project-123456/custom-build-php-prod:7.4.6-fpm-alpine3.11
```

So you only have to push it:

```bash
docker push [HOSTNAME]/[PROJECT-ID]/[IMAGE]:[TAG]
docker push eu.gcr.io/project-123456/custom-build-php-prod:7.4.6-fpm-alpine3.11
```

When you push an image to a registry with a new hostname, Container Registry creates a storage bucket in the specified multi-regional location. After pushing your image, you can go to the GCP Console to view the registry and image under:

***Console 🡒 Storage 🡒 Browser***

or:

***Console 🡒 Container registry 🡒 Images***

**WARNING:** Do not change Bucket policy & ACLs to Bucket only, it will prevent push command to work.
