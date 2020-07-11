ARG base_image
FROM $base_image

ARG listen_port

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        gettext \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/*

EXPOSE $listen_port
EXPOSE 6082
