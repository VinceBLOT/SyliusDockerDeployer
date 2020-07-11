<?php

namespace Deployer;

/**
 * Migrate
 *
 * Doctrine migration tasks.
 */
task('macro:migrate', [
    'sylius:doctrine:cache:clear',
    'sylius:php:restart',
    'sylius:migrations:migrate',
    'sylius:migrations:log_version',
])->shallow();

/**
 * This is a sensible scenario. It shouldn't fail in
 * production, only unexpected and unpredictable things
 * will trigger this fail, so no rollback task is assigned,
 * manual intervention will be required.
 */
fail('macro:migrate', 'deploy:failed');
