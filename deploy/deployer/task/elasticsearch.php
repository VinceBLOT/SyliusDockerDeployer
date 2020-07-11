<?php

namespace Deployer;

/**
 * Populate elasticsearch via fos:elastica:populate
 *
 * To repopulate on each deploy we just run the same
 * populate command. As it is run without --no-reset
 * it will effectively recreate our index.
 *
 * fos:elastica:populate [--index[="..."]]
 * [--type[="..."]] [--no-reset] [--offset="..."]
 * [--sleep="..."] [--batch-size="..."]
 * [--ignore-errors]
 */
desc('Populate elasticsearch');
task('sylius:elasticsearch:populate', function () {
    if (get('with_elasticsearch') === true) {
        runService('php', '{{bin/console}} fos:elastica:populate');
    }
});
