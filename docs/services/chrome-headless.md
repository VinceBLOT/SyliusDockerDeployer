# Chrome headless

If you use Sylius version below `1.7.5` you should use [Selenium chrome](selenium-chrome.md) instead.

## Configuration

* To enable `chrome-headless`:

    ```bash
    # env/docker/services
    WITH_CHROME_HEADLESS=1
    ```

### App configuration

* To test your development repo you have to make some changes to `behat.yml`:

    ```yml
    # /behat.yml
    default:
        extensions:
            Behat\MinkExtension:
                # Change this
                base_url: "http://nginx:8000/"
                sessions:
                    chrome_headless:
                        chrome:
                            # Change this
                            api_url: "http://chrome-headless:9222"
    ```
