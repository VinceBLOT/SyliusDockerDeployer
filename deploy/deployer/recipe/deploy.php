<?php

namespace Deployer;

/**
 * Deploy remote prod
 *
 * It deploys app in remote server and migrate database.
 * It doesn't build, it only uploads pre-existent (and
 * tested) build.
 */
task('deploy', [
    'sylius:lock:check',
    'macro:pre_release',
    'macro:upload',
    'sylius:maintenance:on',
    'macro:migrate',
    'macro:refresh',
    'macro:release',
    'sylius:maintenance:off',
]);

after('deploy', 'success');
fail('deploy', 'deploy:failed');
