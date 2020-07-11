# Varnish

## Configuration

### Templates

Varnish doesn't support environment variables in config files by default. To be able to configure Varnish via env vars `envsubst` is used.

Instead of using a regular `custom.vcl` file, a file template like `custom.vcl.PROFILE.template` with placeholders for env vars substitution is used, and the actual substitution is done in `docker-entrypoint.sh`.

```bash
envsubst '$SERVER_NAME ...' < default.conf.template > default.conf
```

### Profiles

To be able to manage multiple stages via env vars, Varnish configuration support profiles. `custom.vcl` is a folder with multiple profiles like `custom.vcl.PROFILE.template`. 

Available profiles are:

* `DISABLED` (Varnish running, but doesn't cache anything)
* `LOCAL` (Same as production, but with www redirection disabled)
* `PRODUCTION` (Varnish enabled)

You can see more info (and also set what profile to use) in `env/docker/varnish`.

## Enable

As nginx could be talking to `varnish` or `nginx` service, you should configure a couple of env vars to enable varnish:

```bash
# env/docker/services
WITH_VARNISH=1

# env/docker/network
PROXY_DOWNSTREAM_HOST=varnish
PROXY_DOWNSTREAM_PORT=${VARNISH_PORT}
```
