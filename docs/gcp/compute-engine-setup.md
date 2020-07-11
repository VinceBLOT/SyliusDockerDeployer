# Compute Engine setup

For testing purposes and to deploy `remote-staging` stage, we will create a compute engine micro instance.

## On Console

### Create instance

*[Console](https://console.cloud.google.com) 🡒 Compute Engine 🡒 VM Instances 🡒 Create*

```
Machine type: f1-micro
Boot disk: Ubuntu 18.04 LTS Minimal
Firewall: Allow HTTP and HTTPS
```

### Switch to static IP

*[Console](https://console.cloud.google.com) 🡒 VPC Network 🡒 External IP addresses 🡒 Type: Static*

### Upload SSH keys

[Generate SSH Keys](keys.md) and upload them:

*[Console](https://console.cloud.google.com) 🡒 Compute Engine 🡒 Metadata 🡒 SSH Keys 🡒 Edit 🡒 Add Item:*

Paste `/sylius/data/keys/ssh/id_rsa.pub` content and save.

## On compute instance

Access your newly created instance:

```bash
ssh -i /sylius/data/keys/ssh/id_rsa username@11.22.33.44
```

### Update system

If you have just created your Cloud Server, some updates might be deployed automatically, that is why commands like `apt`, `dpkg` may not work normally until after some minutes.

```bash
sudo apt update
sudo apt upgrade
sudo apt autoremove
```

### Install dependencies

Some commands are needed on your remote host. Most of them are included in `coreutils` or are part of the system. But some of them need to be installed. Here is the complete package list:

```bash
sudo apt install coreutils cron gettext findutils git grep make openssl rsync sed openssh-client
```

### Enable swap

This is optional and not recommended on production deployments, but needed in `f1-micro` instance due to its low ram.

```bash
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Docker

Check on [Docker documentation](https://docs.docker.com/engine/install/ubuntu/) for up to date installation instructions. 

To manage docker as a non root user:

```bash
sudo groupadd docker
sudo usermod -a -G docker ${USER}

sudo reboot

docker run hello-world
```

### Docker compose

Check on [Docker documentation](https://docs.docker.com/compose/install/) for up to date installation instructions. 

### Reboot

```bash
sudo reboot
```
