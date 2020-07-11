<?php

namespace Deployer;

/**
 * Setup local staging
 *
 * It deploys app in local server and creates empty
 * database schema (and populates it if requested).
 */
task('setup_local_staging', function () {
    if (get('app_env') === 'prod') {
        set('is_dockerized', false);
        invoke('macro:pre_release');
        invoke('macro:build');
        invoke('macro:post_build');
        invoke('macro:setup_db');
        invoke('macro:populate');
        invoke('macro:refresh');
        invoke('macro:release');
        invoke('sylius:maintenance:off');
    } else {
        throw new GracefulShutdownException(
            "Wrong environment.\n".
            sprintf('This task should be called under "prod" environment. Please switch from "%s" to "prod".', get('app_env'))
        );
    }
})->local();

after('setup_local_staging', 'success');
fail('setup_local_staging', 'deploy:failed');
