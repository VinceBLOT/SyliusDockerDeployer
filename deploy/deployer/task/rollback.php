<?php

namespace Deployer;

/**
 * Remove release symlink
 */
desc('Remove release symlink');
task('sylius:rollback:remove_release_symlink', function () {
    run('cd {{deploy_path}} && rm -f release');
});

/**
 * Ensure lock is present
 */
desc('Ensure lock is present');
task('sylius:rollback:ensure_lock', function () {
    $unlocked = test('[ ! -f {{deploy_path}}/.dep/deploy.lock ]');
    if ($unlocked) {
        run('touch {{deploy_path}}/.dep/deploy.lock');
    }
});
