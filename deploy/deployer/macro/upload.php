<?php

namespace Deployer;

/**
 * Upload
 *
 * Upload latest build to remote server and prepare shared
 * and writable folders.
 */
task('macro:upload', [
    'sylius:build:upload',
    'deploy:shared',
    'deploy:writable',
])->shallow();

/**
 * This fail is always triggered before deploy:symlink,
 * and also before any database migration has taken effect,
 * so there is no need to fix anything, because in the next
 * deploy, deploy:release will remove failed release folder. 
 * So we only need to remove lock file.
 */
fail('macro:upload', 'deploy:unlock');
