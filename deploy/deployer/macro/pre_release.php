<?php

namespace Deployer;

/**
 * Pre Release
 *
 * Prepare release environment needed to run migrations and
 * caches refreshing.
 */
task('macro:pre_release', [
    'deploy:info',
    'deploy:prepare',
    'sylius:build:prepare',
    'sylius:migrations:prepare',
    'deploy:lock',
    'deploy:release',
])->shallow();

/**
 * This fail is always triggered before deploy:symlink,
 * and also before any database migration has taken effect,
 * so there is no need to fix anything, because in the next
 * deploy, deploy:release will remove failed release folder. 
 * So we only need to remove lock file.
 */
fail('macro:pre_release', 'deploy:unlock');
