# Workflow

## Local development

### unlock-local

Some local tasks like `update-dev`, `populate-dev` and `build` are managed by Deployer. Deployer places a `.lock` file when working, but if it ends unexpectedly, this lock is not removed. Deployer will warn you the next time and you'll have to remove this `.lock` file manually:

```bash
make unlock-local
```

### dev

To be able to receive mails with `mailhog`, you need to enable it in your app code:

```yaml
# config/packages/dev/swiftmailer.yaml
swiftmailer:
    disable_delivery: false
```

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

To test your development repo you first have to make some changes to your app code. 

* If you use Sylius version `1.7.5` or above, you should use [Chrome headless](services/chrome-headless.md).
* And if you use Sylius version below `1.7.5` you should use [Selenium chrome](services/selenium-chrome.md) instead.

And then, you can run test suites:

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

### unlock-remote

All remote deployments are managed by Deployer. Deployer places a `.lock` file when working, but if it ends unexpectedly, this lock is not removed. Deployer will warn you the next time and you'll have to remove this `.lock` file manually:

```bash
make unlock-remote
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
