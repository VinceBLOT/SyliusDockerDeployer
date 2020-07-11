# Remote setup

## Prerequisites

* Configured [SSH Keypair](gcp/keys.md) to connect to remote host.

* `docker` and `docker-compose` on your remote host.

* Some commands are also needed on your remote host. Most of them are included in `coreutils` or are part of the system. But some of them need to be installed. Here is the complete package list:

  ```bash
  coreutils cron gettext findutils git grep make openssl rsync sed openssh-client
  ```

## Setup

### .env overrides

Some overridden values from [local setup](local-setup.md) will also be used for remote deployment, so if you haven't completed it yet, do it now.

Once you've overridden your local setup values, you should create some more `.override` files to store your custom remote setup values. You could override `prod` or `remote-staging` stages (or both), but for brevity, in this examples you'll find only `prod` references.

* Your remote host domain and ip:

  ```bash
  # env/deploy/hosts.prod.override
  SERVER_NAME=domain.com
  HOST_IP=111.222.333.444
  # Change remote SSH port only if it is other than 22
  REMOTE_PORT=2222
  ```

* Your remote user. This is the user with granted access to your remote host. Sometimes it is "root", but if you have the choice to set it up, setting it to your local user is a good idea.

  ```bash
  # env/deploy/hosts.prod.override
  REMOTE_USER=root
  ```

* Some remote hosts (like google cloud platform) may need to use sudo for filesystem operations:

  ```bash
  # env/deploy/hosts.prod.override
  USE_SUDO=1
  ```

* You domain data for Let's encrypt TLS certificate request:

  ```bash
  # env/deploy/hosts.prod.override
  LETS_ENCRYPT_EMAIL=info@domain.com
  LETS_ENCRYPT_DOMAIN=-d domain.com -d www.domain.com
  ```

* By default `SSL_HEADER_STRICT_TRANSPORT_SECURITY` ships with a `max-age` value of `86400` (one day). The HTTP Strict-Transport-Security response header lets a web site tell browsers that it should only be accessed using HTTPS, instead of using HTTP. It is advised to change this to a higher value like `31536000` (one year) when you are sure everything is running fine in production.

  ```bash
  # env/deploy/hosts.prod.override
  SSL_HEADER_STRICT_TRANSPORT_SECURITY=31536000
  ```

* Also you might want to check [Content Security Policy](https://developer.mozilla.org/es/docs/Web/HTTP/CSP) configuration because you probably want to add (or remove) some domains in `ALLOW_LIST_DOMAINS`.

  ```bash
  # env/deploy/hosts.prod.override
  ALLOW_LIST_DOMAINS=
  ```

* It is strongly advised to build your images on local, upload them to a [private registry](gcp/docker-registry.md) and pull them from remote. But if you prefer to not do that, you can enable this option to also build on remote:

  ```bash
  # env/docker/images.prod.override
  BUILD_ON_REMOTE=1
  ```

* To be able to send emails in production, edit `MAILER_URL`:

  ```bash
  # env/sylius/prod.override
  # If you use for example Amazon SES:
  MAILER_URL=smtp://email-smtp.eu-central-1.amazonaws.com:587?encryption=tls&username=OVERRIDE_ME&password=OVERRIDE_ME
  ```

### Host setup

#### Push to container registry

If you are using a [container registry](gcp/docker-registry.md) to store your production images, it is time to build and [push](gcp/docker-registry-push.md) them.



#### Setup `remote-staging` stage

It creates `stack` folder on remote host, clone this repo and copy `.env` file from local deploy server to remote host and the builds or pull needed docker images and start them:

```bash
make setup-remote-stack-staging
```

Issue a cert request to Let's Encrypt servers. It is advised to first issue a `dry` run:

```bash
make setup-remote-stack-staging-ssl-dry
make setup-remote-stack-staging-ssl
```
#### Setup `prod` stage

It creates `stack` folder on remote host, clone this repo and copy `.env` file from local deploy server to remote host and the builds or pull needed docker images and start them:

```bash
make setup-remote-stack-prod
```

Issue a cert request to Let's Encrypt servers. It is advised to first issue a `dry` run:

```bash
make setup-remote-stack-prod-ssl-dry
make setup-remote-stack-prod-ssl
```

Setup periodic database backups:

```bash
make setup-remote-database-backup
```

### App setup

Now that your remote host is ready to go, you can deploy your app on it.

#### Setup `remote-staging` stage

It uploads your latest app build and creates `prod` database:

```bash
make setup-remote-app-staging
```

#### Setup `prod` stage

It uploads your latest app build and creates `prod` database:

```bash
make setup-remote-app-prod
```

## Next step

Now that you have your setup ready for `remote-staging` and `prod` stages you can [start playing around](workflow.md#Remote-deployment) with it.
