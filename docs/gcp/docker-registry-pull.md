# Pull from Docker registry

## With make

You can pull images from the registry using:

```bash
# All enabled images for that stage
make pull-[stage]

# Only php image
make pull-[stage] service=php
```

## Manually
You also can pull images manually:

***Console 🡒 Container registry 🡒 images 🡒 click on image (twice) 🡒 Show pull command***

Which will show you your container pull command:

```bash
docker pull eu.gcr.io/name-123456/custom-build-php-dev:7.4.6-fpm-alpine3.11
```
