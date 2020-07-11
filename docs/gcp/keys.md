# SSH Keys

To be able to deploy to a remote server you'll need a SSH Keypair. Some providers let you upload your public key and others provide you with theirs. Depending on this you'll have to generate it and upload or just copy the provided one in `sylius/data/keys/ssh` folder.

## Generate key and upload to remote host

If your remote host let you upload your public key, you only need to generate and upload it.

First of all you'll want to configure it. By default, keys are generated with `id_rsa` name and only one keypair is generated both form `remote-staging` and `prod` stages. If you want to override this, you have to create an `.override` env file (or files, if you want to override both stages with different values) and set the new name:

```bash
# All of these override schemes are possible:
# env/deploy/hosts.override
# env/deploy/hosts.prod.override
# env/deploy/hosts.remote-staging.override
REMOTE_IDENTITY=your_overridden_name
```

And then, generate your keys:

```bash
# Generate keys for staging server
make setup-remote-stack-staging-keys

# Generate keys for prod server
make setup-remote-stack-prod-keys
```

Once keys are generated you'll find it in `sylius/data/keys/ssh` folder, ready to be uploaded.

## Download key provided by remote host

If you have an already generated key (or keys), you just have to place it in:

```bash
sylius/data/keys/ssh
```

Then, you have to create an `.override` env file (or files, if you want to override both stages with different values) and set its name:

```bash
# All of these override schemes are possible:
# env/deploy/hosts.override
# env/deploy/hosts.prod.override
# env/deploy/hosts.remote-staging.override
REMOTE_IDENTITY=your_downloaded_key
```

After that, ensure it has proper permissions:

```bash
chmod 400 sylius/data/keys/ssh/your_downloaded_key
```
