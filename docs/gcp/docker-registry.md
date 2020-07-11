# Docker container registry

It is strongly advised to build your Docker images on local, upload them to a private registry and pull them from remote.

## Setup 

* Enable registry on: ***[Console](https://console.cloud.google.com) 🡒 Container registry 🡒 Enable API***

* For non google cloud platform hosts, install [Google Cloud SDK](sdk.md).

* And finally configure docker to use gcloud as a credential helper:

    ```bash
    gcloud auth configure-docker
    ```

     Set `docker-credential-gcloud` in system `PATH`:

    ```bash
    sudo ln -s /snap/google-cloud-sdk/current/bin/docker-credential-gcloud /usr/local/bin
    ```

## Usage

* [Push to registry](docker-registry-push.md)
* [Pull from registry](docker-registry-pull.md)
