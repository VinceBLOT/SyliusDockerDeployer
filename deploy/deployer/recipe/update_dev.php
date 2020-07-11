<?php

namespace Deployer;

use Deployer\Exception\GracefulShutdownException;

/**
 * Update local dev
 *
 * It sets /sylius/prod/current as the release_path, to
 * mimic production release environment and be consistent
 * with nginx public_path.
 *
 * It sets is_dockerized to false, because database
 * operations are already run inside app container.
 */
task('update_dev', function () {
    if (get('app_env') === 'dev') {
        set('release_path', get('static_release_path'));
        invoke('macro:build');
        set('is_dockerized', false);
        invoke('macro:refresh');
    } else {
        throw new GracefulShutdownException(
            "Wrong environment.\n".
            sprintf('This task should be called under "dev" environment. Please switch from "%s" to "dev".', get('app_env'))
        );
    }
})
    ->local()
    ->shallow();

after('update_dev', 'success');
fail('update_dev', 'deploy:failed');
