# Make API Reference

## Setup

### Local

#### Host

```bash
make setup-local-stack
```

#### App

```bash
make setup-dev
make populate-dev
make setup-test
make setup-local-staging
```

### Remote staging

#### Host

```bash
make setup-remote-stack-staging-keys
make setup-remote-stack-staging
make setup-remote-stack-staging-ssl-dry
make setup-remote-stack-staging-ssl
```

#### App

```bash
make setup-remote-app-staging
```

### Remote production

#### Host

```bash
make setup-remote-stack-prod-keys
make setup-remote-stack-prod
make setup-remote-stack-prod-ssl-dry
make setup-remote-stack-prod-ssl
make setup-remote-database-backup
```

#### App

```bash
make setup-remote-app-prod
```

## Workflow

### Local

```bash
make unlock-local
make update-dev
make populate-dev
make build
```

### Remote staging

```bash
make unlock-remote
make deploy-staging
make rollback-staging
```

### Remote production

```bash
make unlock-remote
make deploy-prod
make rollback-prod
```

## Docker

### Development

```bash
make env-dev
make build-dev [service=service-name]
make pull-dev [service=service-name]
make up-dev [service=service-name]
make reload-dev [service=service-name]
make down-dev [service=service-name]
```

### Test

```bash
make env-test
make build-test [service=service-name]
make pull-test [service=service-name]
make up-test [service=service-name]
make reload-test [service=service-name]
make down-test [service=service-name]
```

### Build

```bash
make env-build
make up-build [service=service-name]
make down-build [service=service-name]
```

### Local staging

```bash
make env-local-staging
make build-local-staging [service=service-name]
make pull-local-staging [service=service-name]
make up-local-staging [service=service-name]
make reload-local-staging [service=service-name]
make down-local-staging [service=service-name]
```

### Remote staging

```bash
make env-remote-staging
make build-remote-staging [service=service-name]
```

### Production

```bash
make env-prod
make build-prod [service=service-name]
make pull-prod [service=service-name]
make up-prod [service=service-name]
make reload-prod [service=service-name]
make down-prod [service=service-name]
make cleanup-prod
```

## Services

```bash
make proxy
make varnish
make nginx
make php
make mysql
make elasticsearch
make mailhog
make adminer
make kibana
make chrome-headless
make selenium-chrome
make memcached
```

## Helpers

### Local

```bash
make run-tests
make set-maintenance-on
make set-maintenance-off
```

### Production

```bash
make set-remote-maintenance-on
make set-remote-maintenance-off
make run-remote-database-backup
```
