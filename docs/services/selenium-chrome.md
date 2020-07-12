# Selenium chrome

If you use Sylius version `1.7.5` or above, you should use [Chrome headless](chrome-headless.md).

## Configuration

* To enable `selenium-chrome`:

    ```bash
    # env/docker/services
    WITH_SELENIUM_CHROME=1
    ```

* If `APP_ENV` is set to `test_cached` you also have to enable `memcached`:

    ```bash
    # env/docker/services
    WITH_MEMCACHED=1
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
                    chrome:
                        selenium2:
                            # Add this
                            wd_host: "http://selenium-chrome:4444/wd/hub"
    ```

* Also, if `APP_ENV` is set to `test_cached` you have to set `memcached` as `host` on `config/packages/test_cached/doctrine.yaml`:

    ```yml
    # config/packages/test_cached/doctrine.yaml
    doctrine:
        orm:
            entity_managers:
                default:
                    result_cache_driver:
                        type: memcached
                        host: memcached
                        port: 11211
                    query_cache_driver:
                        type: memcached
                        host: memcached
                        port: 11211
                    metadata_cache_driver:
                        type: memcached
                        host: memcached
                        port: 11211
    ```
