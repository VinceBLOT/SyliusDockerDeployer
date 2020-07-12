# Local setup

## Prerequisites

* Needless to say: `docker` and `docker-compose`.
* Some commands are also needed on your local host. Most of them are included in `coreutils` or are part of the system. But some of them need to be installed. Here is the complete package list:

  ```bash
  coreutils cron gettext findutils git grep make openssl rsync sed openssh-client
  ```

### OAuth token for composer and git clone private repos

This setup assumes that you have your app repository hosted on github (Or at least an account, to be able to play with Sylius-Standard). To be able to fetch the source from github, and also to prevent composer to reach rate limits, you need a [Github OAuth Token](https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line).

To get it, go to:

***Settings 🡒 Developer settings 🡒 Personal access tokens 🡒 Generate new token***:

* Token description: composer
* Scope: repo

Once you have your token, save it for later (you'll need to store it in an env var).

## Setup

Create project folder named `Sylius` to store stack code and clone `SyliusDockerDeployer` repo there:

```bash
cd /path/to/Sylius
git clone https://github.com/anthid/SyliusDockerDeployer.git .
```

Ensure right permissions are set to all stack files and needed folders (`sylius/dev`) are created:

```bash
make setup-local-stack
```

### .env overrides

Before anything else, you should create some `.override` files to store your custom configuration values:

* Your local user/uid (Non root user). This user will be used to create a regular user inside php container:

  ```bash
  # env/deploy/hosts.override
  LOCAL_USER=OVERRIDE_ME
  LOCAL_USER_UID=OVERRIDE_ME
  ```

* Your Github OAuth token and your app repository:

  ```bash
  # env/deploy/source.override
  GITHUB_OAUTH_TOKEN=OVERRIDE_ME
  # To use your own app repo (instead Sylius-Standard) use the following format:
  APP_REPO=https://${GITHUB_OAUTH_TOKEN}:x-oauth-basic@github.com/your/Repo.git
  ```

* Your application secret and database password:

  ```bash
  # env/sylius/sylius.override
  APP_SECRET=OVERRIDE_ME
  MYSQL_ROOT_PASSWORD=OVERRIDE_ME
  ```

  If you need it, you can generate random values with:

  ```bash
  < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;
  ```

### App setup

Once you have setup all needed env vars, is time to tell Deployer to setup all local development stages.

#### Setup `dev` stage

* First of all, as setup command also populates database, you have to select what type of data you want to be populated. For `dev` stage default is `fixtures`, but you can change it:

  ```bash
  # env/deploy/deploy.dev.override
  # Values: 0|setup|fixtures|dump (dump is not implemented yet)
  POPULATE_DATABASE=setup
  ```

* To be able to receive mails with `mailhog` during development, you need to enable it in your app code:

  ```yaml
  # config/packages/dev/swiftmailer.yaml
  swiftmailer:
      disable_delivery: false
  ```

Once you have defined that, setup will clone app repo, build it, generate `dev` cache, drop database if exist, create new database and populate it:

```bash
make setup-dev
```

#### Setup `test` stage

* First of all you have to define in what app environment your tests will run. During development, usually `test` is used, while `test_cached` is used for CI.

    ```bash
    # env/sylius/sylius.test
    APP_ENV=test
    ```

* Then you also have to make some changes to your app code:

  * If you use Sylius version `1.7.5` or above, go see [Chrome headless](services/chrome-headless.md).
  * And if you use Sylius version below `1.7.5` go to [Selenium chrome](services/selenium-chrome.md) instead.

It will use previously cloned repo, generate `test` cache, drop `test` database if exist, and create new `test` database:

```bash
make setup-test
```

#### Setup `local-staging` stage

It will checkout app from remote repo, build it, drop local `prod` database if exist, and create new local `prod` database. This is the build to test and on success deploy to production:

```bash
make setup-local-staging
```

## Next step

Now that you have your setup ready for `dev`, `test` and `local-staging` stages you can [start playing around](workflow.md) with it.
