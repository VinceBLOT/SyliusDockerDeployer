# Workflow

## Local development

### unlock

Some local tasks like `update-dev`, `populate-dev` and `build` are managed by Deployer. Deployer places a `.lock` file when working, but if it ends unexpectedly, this lock is not removed. Deployer will warn you the next time and you'll have to remove this `.lock` file manually:

```bash
make unlock-local
```

### dev

To create a running instance of your development environment:

```bash
make up-dev
# browse it in http://localhost
# To enter any of the docker services: make [service]
make php
# To stop your running instance
make down-dev
```

You can also update your development repo (Usually when you want to change branch and build it again). It drops `sylius/dev` so be careful and remember to commit all changes before:

```bash
make update-dev
```

By default `update-dev` doesn't populate database, so if you want some data to start:

```bash
make populate-dev
```

### test

To run test suites:

```bash
# Test script is located on /deploy/scripts/run-tests.sh
make run-tests
```
### build

To build your latest commit:

```bash
make build
```

### local-staging

After a successful build, you can browse it in local:

```bash
make up-local-staging
# browse in http://localhost
# To enter any of the docker services: make [service]
make php
# To stop your running instance
make down-local-staging
```

This build is a production build, so if everything is correct, you can safely deploy to remote.

## Remote deployment

### unlock

All remote deployments are managed by Deployer. Deployer places a `.lock` file when working, but if it ends unexpectedly, this lock is not removed. Deployer will warn you the next time and you'll have to remove this `.lock` file manually:

```bash
make unlock-staging
make unlock-prod
```

### remote-staging

After you have successfully tested your build on `local-staging` you can deploy it to `remote-staging`:

```bash
make deploy-staging
```

Also you'll want to test how your deploy rolls back:

```bash
make rollback-staging
```

### prod

After you have successfully tested on `remote-staging` you can finally deploy to `prod`:

```bash
make deploy-prod
```

And (hopefully not needed):

```bash
make rollback-prod
```
