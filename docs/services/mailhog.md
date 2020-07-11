# Mailhog

Webmail catcher for development stages. It exposes port `8025` for mailbox frontend `http://localhost:8025` and internal `1025` for smtp relay. 

## Configuration

* You can change `mailhog` public port:

    ```bash
    # env/docker/network
    MAILHOG_PORT=8025
    ```

* It also has to be defined as your app mailer:

    ```bash
    # env/sylius/sylius
    MAILER_URL=smtp://mailhog:1025
    ```

### App configuration

* To be able to receive mails with `mailhog`, you need to enable it in your app code:

    ```yaml
    # config/packages/dev/swiftmailer.yaml
    swiftmailer:
        disable_delivery: false
    ```
