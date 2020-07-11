# Environment variables

Environment variables are meant to configure all aspects of the stack and are located in `env` folder. Instead of having one big `.env` file, they are stored in separated files, grouped by topics to improve readability, but at the end they are all compiled to one unique `.env` file.

## Organizing env vars files

Almost all env vars have global default values (applicable to all [stages](stages.md)). Global default values files are stored following the pattern `folder/topic`, and stage specific are defined by appending `stage` at the end of the file: `folder/topic.stage[.stage]`. You can combine multiple stages in one file, like `deploy.dev.local-staging` to share env vars across multiple stages.

To override defaults, you should create a new file ending in `.override` to avoid editing defaults files directly. `.override` files are created to store your custom (per project) variables.

Precedence pattern:

```bash
# higher precedence
folder/topic.stage[.stage].override
folder/topic.override
folder/topic.stage[.stage]
folder/topic
# lower precedence
```

## Variable substitution

You can use env vars as a value for another env var, for example, the following is allowed:

```bash
MYSQL_DATABASE=sylius_dev
MYSQL_ROOT_PASSWORD=some_random_hash
# env var as an env var value:
DATABASE_URL=mysql://root:${MYSQL_ROOT_PASSWORD}@mysql/${MYSQL_DATABASE}
```

Just try to avoid circular references and you'll be safe.
