<?php

namespace Deployer;

use Deployer\Exception\GracefulShutdownException;

/**
 * Setup local test
 *
 * It sets /sylius/prod/current as the release_path, to
 * mimic production release environment and be consistent
 * with nginx public_path.
 *
 * It sets is_dockerized to false, because database
 * operations are already run inside app container.
 */
task('setup_test', function () {
    if (get('app_env') === 'test_cached') {
        set('release_path', get('static_release_path'));
        invoke('sylius:cache:clear');
        invoke('sylius:cache:warmup');
        set('is_dockerized', false);
        invoke('macro:setup_db');
    } else {
        throw new GracefulShutdownException(
            "Wrong environment.\n".
            sprintf('This task should be called under "test_cached" environment. Please switch from "%s" to "test_cached".', get('app_env'))
        );
    }
})
    ->local()
    ->shallow();

after('setup_test', 'success');
fail('setup_test', 'deploy:failed');
