# Stages

Every application have multiple development environments and deployment stages. This setup covers all of them from `dev` to `prod`.

At a **higher level** (or conceptual level) the covered stages are:

* `dev`, `test`, `build`, `local-staging`, `remote-staging` and `prod`.

These are the stages you'll find and use as [filters](env-vars.md#organizing-env-vars-files) for env vars files and also the stages you have available in [make API](make-api.md). So you only have to worry about these stages, the next section is only useful if you plan to override some [docker compose](docker.md) definitions.

## docker-compose and APP_ENV stages

As we go down the path to the [docker-compose](docker.md#docker-compose) level and `APP_ENV` level, available stages are:

* **docker-compose stages**: `dev`, `test`, `build`, `local-staging` and `prod`.
* **App stages** (`APP_ENV`): `dev`, `test_cached` and `prod`.

Taking this into account, not all stages are read the same across the three levels:

* For example, at **higher level** `remote-staging` and `prod` are two different stages. They are run in different locations and have different configuration parameters. But at **docker-compose level** and **application level** both are the same stage: `prod`.

* Also there is the `build` special case. When you setup production stages, `local-staging` for example, docker-compose is run as `build`, but when you run that stage after setup, docker-compose is then run as `local-staging`.

The complete stages matrix is as follows:

| Conceptual stages | docker-compose | APP_ENV |
|---------- |------------------- |-------- |
| dev | dev | dev |
| test | test | test_cached |
| build | build | prod |
| local-staging | local-staging | prod |
| remote-staging | prod | prod |
| prod | prod | prod |
