# ElasticSearch

## Configuration

* The value for this setting depends on the amount of RAM available on your server. By default is set to 1g, but probably must be set to a higher value in production:

    ```bash
    # env/docker/elasticsearch
    ELASTICSEARCH_HEAP_SIZE=1g
    ```

    More info on [Elasticsearch docs](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/heap-size.html).

## System configuration

You'll have to perform some system configuration also. Check [elasticsearch documentation](https://www.elastic.co/guide/en/elasticsearch/reference/6.8/system-config.html) for an up to date reference.
