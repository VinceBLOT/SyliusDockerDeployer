<?php

namespace Deployer;

/**
 * Setup remote prod
 *
 * It deploys app in remote server and creates empty
 * database schema (and populates it if requested). It
 * doesn't build, it only uploads pre-existent (and
 * tested) build.
 */
task('setup_prod', [
    'sylius:lock:check',
    'macro:pre_release',
    'macro:upload',
    'macro:setup_db',
    'macro:populate',
    'macro:refresh',
    'macro:release',
    'sylius:maintenance:off',
]);

after('setup_prod', 'success');
fail('setup_prod', 'deploy:failed');
