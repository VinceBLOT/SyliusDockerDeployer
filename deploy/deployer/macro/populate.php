<?php

namespace Deployer;

/**
 * Populate
 *
 * Database first time populate.
 */
task('macro:populate', [
    'sylius:database:populate',
])->shallow();

/**
 * This is a sensible scenario. It shouldn't fail in
 * production, only unexpected and unpredictable things
 * will trigger this fail, so no rollback task is assigned,
 * manual intervention will be required.
 */
fail('macro:populate', 'deploy:failed');
