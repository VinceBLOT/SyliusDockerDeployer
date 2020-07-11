<?php

namespace Deployer;

/**
 * Post build
 *
 * Pack as a tar file to optimize upload time.
 */
task('macro:post_build', [
    'deploy:clear_paths',
    'sylius:build:tar',
    'deploy:shared',
])->shallow();

/**
 * This fail is always triggered before deploy:symlink,
 * and also before any database migration has taken effect,
 * so there is no need to fix anything, because in the next
 * deploy, deploy:release will remove failed release folder. 
 * So we only need to remove lock file.
 */
fail('macro:post_build', 'sylius:lock:unlock_local');
