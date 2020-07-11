<?php

namespace Deployer;

/**
 * Setup database
 *
 * Database first time setup.
 */
task('macro:setup_db', [
    'sylius:php:restart',
    'sylius:database:drop',
    'sylius:database:create',
    'sylius:migrations:migrate',
    'sylius:migrations:log_version',
])->shallow();

/**
 * This is a sensible scenario. It shouldn't fail in
 * production, only unexpected and unpredictable things
 * will trigger this fail, so no rollback task is assigned,
 * manual intervention will be required.
 */
fail('macro:setup_db', 'deploy:failed');
