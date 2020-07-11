# Sylius setup with Docker and Deployer

## Overview

The goal of this setup is to abstract away some boring tasks and make the development and deployment of Sylius applications as smooth as possible. It features *one click deployments*, so along the way it makes some opinionated design choices. But otherwise it is fairly flexible and easy to use. Some features and characteristics are:

* It supports multiple stages: `dev`, `test`, `build`, `local-staging`, `remote-staging` and `prod`.
* Extensive use of environment variables that can be customized for every stage and use case.
* Shell scripts to provision and configure remote hosts, and [Deployer](https://github.com/deployphp/deployer) to build locally and deploy on remote.
* Uses `make` targets as an `API`. All shell scripts and deployer tasks have their `make` "endpoints".
* Flexible use of `docker-compose`. Enable and disable services with environment variables.

## Documentation

### Basic concepts

* [Stages](docs/stages.md)
* [Environment variables](docs/env-vars.md)
* [Folder structure](docs/folder-structure.md)
* [Docker](docs/docker.md)

### Setup

* [Local setup](docs/local-setup.md)

### Remote setup

* [Google Cloud account](docs/gcp/README.md) *(optional)*
* [Google Cloud Docker registry](docs/gcp/docker-registry.md) *(optional)*
* [Google Cloud Compute engine](docs/gcp/compute-engine-setup.md) *(optional)*
* [Remote setup](docs/remote-setup.md)

### Workflow

* [Workflow](docs/workflow.md)
* [API Reference](docs/make-api.md)

## Next steps

This setup is a **work in progress** so expect some unfinished features, and many ideas to implement *some day*, like:

* Pack configuration files and application code inside images.
* Implement database backup script.
* Implement Varnish beyond POC.
* ...

## Support

This setup only requires a basic understanding of docker and docker-compose, but if you face any problem, ask for help in Sylius slack `#docker` channel.

## License

[MIT](https://github.com/anthid/SyliusDockerDeployer/blob/master/LICENSE)
