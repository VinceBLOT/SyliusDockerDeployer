<?php

namespace Deployer;

/**
 * Data caches refreshing
 *
 * This is a convenience macro, all services need to be
 * enabled/disabled in config.php:
 *
 *   set('with_elasticsearch', true);
 *   set('with_varnish', true);
 */
task('macro:refresh', [
    'sylius:php:restart',
    'sylius:elasticsearch:populate',
    'sylius:varnish:purge',
])->shallow();

/**
 * This is a sensible scenario. It shouldn't fail in
 * production, only unexpected and unpredictable things
 * will trigger this fail, so no rollback task is assigned,
 * manual intervention will be required.
 */
fail('macro:refresh', 'deploy:failed');
