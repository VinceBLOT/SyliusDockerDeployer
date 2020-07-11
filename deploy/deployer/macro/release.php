<?php

namespace Deployer;

/**
 * Release
 *
 * After successful migrations and all other operations
 * release task only does the atomic symlink.
 */
task('macro:release', [
    'deploy:symlink',
    'deploy:unlock',
    'cleanup',
])->shallow();

/**
 * This is a sensible scenario. It shouldn't fail in
 * production, only unexpected and unpredictable things
 * will trigger this fail, so no rollback task is assigned,
 * manual intervention will be required.
 */
fail('macro:release', 'deploy:failed');
