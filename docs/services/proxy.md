# Nginx SSL termination proxy

## Configuration

### Templates

Nginx doesn't support environment variables in config files by default. To be able to configure Nginx via env vars `envsubst` is used.

Instead of using a regular `default.conf` file, a file template like `default.conf.PROFILE.template` with placeholders for env vars substitution is used, and the actual substitution is done in `docker-entrypoint.sh`.

```bash
envsubst '$SERVER_NAME ...' < default.conf.template > default.conf
```

### Profiles

To be able to manage `WWW` and `NON-WWW` subdomains, an also to manage `SECURE` (with SSL certificate) and `NON-SECURE` (Without SSL certificate) scenarios, nginx configuration support profiles. `default.conf` is a folder with multiple profiles like `default.conf.PROFILE.template`. 

Available profiles are:

* `NON-SECURE-NON-WWW`
* `NON-SECURE-WWW`
* `SECURE-NON-WWW`
* `SECURE-WWW`

You can see more info (and also set what profile to use) in `env/docker/proxy`.

### Downstream host (Varnish or Nginx)

As nginx could be talking to `varnish` or `nginx` service, it needs a couple of env vars to know where the downstream host is:

```bash
# env/docker/network

# Values: varnish|nginx
PROXY_DOWNSTREAM_HOST=nginx
# Values: ${NGINX_PORT}|${VARNISH_PORT}
PROXY_DOWNSTREAM_PORT=${NGINX_PORT}
```

## Maintenance mode

To be able to perform consistent deployments, nginx should be able to enter in **maintenance mode** to avoid database access during deployment.

Nginx enters maintenance mode when `/var/www/maintenance/maintenance_on.html` is found. Otherwise it will continue to `index.php` as normal.

```nginx
    root /var/www/maintenance;
    location / {
        if (-f $document_root/maintenance_on.html) {
            return 503;
        }

        ...
    }
    
    error_page 503 @maintenance;
    location @maintenance {
            rewrite ^(.*)$ /maintenance_on.html break;
    }
```
