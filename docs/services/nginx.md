# Nginx

## Configuration

### Templates

Nginx doesn't support environment variables in config files by default. To be able to configure Nginx via env vars `envsubst` is used.

Instead of using a regular `default.conf` file, a file template like `default.conf.PROFILE.template` with placeholders for env vars substitution is used, and the actual substitution is done in `docker-entrypoint.sh`.

```bash
envsubst '$SERVER_NAME ...' < default.conf.template > default.conf
```

### Profiles

To be able to manage `WWW` and `NON-WWW` subdomains, nginx configuration support profiles. `default.conf` is a folder with multiple profiles like `default.conf.PROFILE.template`. 

Available profiles are:

* `NON-WWW`
* `WWW`

You can see more info (and also set what profile to use) in `env/docker/nginx`.
