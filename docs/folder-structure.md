# Folder structure

## /deploy

* ### /deploy/deployer

  [PHP Deployer](https://github.com/deployphp/deployer) code to build and deploy app related code. Deployer is organized in various levels. Its entrypoint is `deploy.php` file.

  * #### /deploy/deployer/config

    All relevant config options are set via environment variables, so there is no need to edit `config.php` directly.

  * #### /deploy/deployer/functions

    `runService`: To easily decouple deployer from docker, `runService` reads `is_dockerized` env var and executes `run` command inside or outside docker container.

  * #### /deploy/deployer/tasks

    Simple atomic tasks. They don't know where they are called from. They doesn't emit success nor fail.

  * #### /deploy/deployer/macros

    Groups of tasks. Can be called standalone and grouped as a recipe. Can trigger fail and success messages.

  * #### /deploy/deployer/recipes 

    Recipes are like deployer `API`, a group of macros and tasks coupled to some stage action. They always have a `make` endpoint.

* ### /deploy/scripts

  `/bin/sh` scripts to be run either on local or remote host. These scripts are not meant to be called directly, they should always have a `make` endpoint.

* ### /deploy/makefiles

  Here you'll find all `makefiles` which serve as the API endpoints that unifies all shell and deployer commands.

## /docker

* ### /docker/compose

  [Docker compose](docker.md#docker-compose) files. They are separated by services to enable/disable them by env vars in `env/docker/services`.

* ### /docker/images

  Docker images related files. Mainly `Dockerfile` and service specific configuration files.

* ### /docker/volumes

  Volumes related to services, Like caches, logs, etc. But they are not related to application data.

## /env

[Environment variables](env-vars.md). You can create any folder and any filename inside as long as it follows the expected pattern:

```bash
folder/topic.stage[.stage].override
folder/topic.override
folder/topic.stage[.stage]
folder/topic
```

## /sylius

* ### /sylius/prod

  Where Deployer store production releases for `local-staging`, `remote-staging` and `prod` stages. It is mounted as `/home/[user]/stack/prod` inside app container.

* ### /sylius/dev

  Your development repo. It will be created at setup with `make setup-local-stack`. It is mounted as `/home/[user]/stack/prod/current` inside app container to mimic production path.

  * #### /sylius/prod/shared

    App folders that should be persisted between releases. It is configured in `deploy/deployer/config/config.php`:

    ```php
    set('shared_dirs', [
        'public/media',
        ]);
    ```

* ### /sylius/data

  App data folder. Mysql databases, PHP Sessions, Elasticsearch data folder, and all persistent data related to your app.