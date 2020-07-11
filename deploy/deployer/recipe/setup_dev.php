<?php

namespace Deployer;

use Deployer\Exception\GracefulShutdownException;

/**
 * Setup local dev
 *
 * It sets /sylius/prod/current as the release_path, to
 * mimic production release environment and be consistent
 * with nginx public_path.
 *
 * It sets is_dockerized to false, because database
 * operations are already run inside app container.
 */
task('setup_dev', function () {
    if (get('app_env') === 'dev') {
        set('release_path', get('static_release_path'));
        invoke('macro:build');
        set('is_dockerized', false);
        invoke('macro:setup_db');
        invoke('macro:populate');
        invoke('macro:refresh');
        invoke('sylius:maintenance:off');
    } else {
        throw new GracefulShutdownException(
            "Wrong environment.\n".
            sprintf('This task should be called under "dev" environment. Please switch from "%s" to "dev".', get('app_env'))
        );
    }
})
    ->local()
    ->shallow();

after('setup_dev', 'success');
fail('setup_dev', 'deploy:failed');
