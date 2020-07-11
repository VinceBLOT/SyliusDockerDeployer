<?php

namespace Deployer;

/**
 * Console cache:clear command
 */
desc('Clear cache');
task('sylius:cache:clear', function () {
    run('{{bin/console}} cache:clear --no-warmup');
});

/**
 * Console cache:warmup command
 */
desc('Warm up cache');
task('sylius:cache:warmup', function () {
    run('{{bin/console}} cache:warmup');
});
