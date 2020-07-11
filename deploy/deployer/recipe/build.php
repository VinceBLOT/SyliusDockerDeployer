<?php

namespace Deployer;

/**
 * Build
 *
 * It builds app in local server and migrates local prod
 * database.
 */
task('build', function () {
    if (get('app_env') === 'prod') {
        set('is_dockerized', false);
        invoke('macro:pre_release');
        invoke('macro:build');
        invoke('macro:post_build');
        invoke('macro:migrate');
        invoke('macro:refresh');
        invoke('macro:release');
    } else {
        throw new GracefulShutdownException(
            "Wrong environment.\n".
            sprintf('This task should be called under "prod" environment. Please switch from "%s" to "prod".', get('app_env'))
        );
    }
})->local();

after('build', 'success');
fail('build', 'deploy:failed');
