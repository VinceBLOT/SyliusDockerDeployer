# Google Cloud SDK

Google cloud SDK is the tool to manage google cloud resources from remote hosts. You'll need a google cloud account and a project created to assign to SDK.

## Installation

Go to the official [Google Cloud SDK documentation](https://cloud.google.com/sdk/install) to follow installation instructions for your operating system.

## Setup authentication

There are two authentication methods: **User credentials** and **Service account**. `gcloud init` will authenticate with user credentials, so it must be run **only** on your local machine (**not** on deploy server). You'll use service account credentials on deploy server.

### User credentials (Only on local machine)

Run this command in a terminal to start Google Cloud SDK setup:

```bash
gcloud init
```

* Now, an interactive terminal will ask you some questions, first one is the account to use:

    ```bash
    # Usually option [1] is selected
    Choose the account you would like to use to perform operations for 
    this configuration:
    [1] your.email@gmail.com
    [2] Log in with a new account
    ```
* Next choose what project to use:

    ```bash
    # Usually option [1] is selected
    Pick cloud project to use: 
    [1] project-123456
    [2] Create a new project
    ```

* And finally Compute Region:

    ```bash
    # You can choose either "Y" or "n"
    Do you want to configure a default Compute Region and Zone? (Y/n)?  n
    ```

### Service account (Only on deployment server)

#### On console

* Create a service account on:

  ***Console 🡒 IAM & admin 🡒 Service accounts 🡒 Create Service Account***

  * Name: Sylius deployment server
  * Role: *Cloud Storage 🡒 **Storage Object Viewer***

* Now generate JSON key and store it:

  ***Actions 🡒 Create key 🡒 JSON 🡒 Create***

#### On deployment server

* Upload JSON key to your deployment server and activate service account:

  ```bash
  # Activate
  gcloud auth activate-service-account your-service-account@project-123456.iam.gserviceaccount.com --key-file=key.json

  # Set auth account
  gcloud config set account your-service-account@project-123456.iam.gserviceaccount.com
  ```

## Commands and Utilities

To view the active configuration:

```bash
gcloud config list
```

To view current activated account:

```bash
gcloud auth list
```

Which **project** inside google account will be used:

```bash
# list projects
gcloud projects list
# get current project
gcloud config get-value project
# set current project
gcloud config set project PROJECT_ID
```

## Next steps

Now that you have your google cloud SDK setup ready, you can [push](docker-registry-push.md) some images to the registry.
