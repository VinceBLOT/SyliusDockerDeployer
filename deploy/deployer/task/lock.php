<?php

namespace Deployer;

use Deployer\Exception\GracefulShutdownException;

/**
 * Check for remote lock file before local build
 */
desc('Check for remote lock file');
task('sylius:lock:check', function () {
    $locked = test('[ -f {{deploy_path}}/.dep/deploy.lock ]');
    if ($locked) {
        $stage = input()->hasArgument('stage') ? ' '.input()->getArgument('stage') : '';
        throw new GracefulShutdownException(
            "Deploy locked.\n".
            sprintf('Execute "dep deploy:unlock%s" to unlock.', $stage)
        );
    }
});

/**
 * Remove local lock file
 */
desc('Remove local lock');
task('sylius:lock:unlock_local', function () {
    invoke('deploy:unlock');
})
    ->local()
    ->shallow();

/**
 * Local unlock alias (to be consistent with "deploy:unlock")
 */
desc('Local unlock alias');
task('deploy:unlock:local', function () {
    invoke('sylius:lock:unlock_local');
})
    ->local()
    ->shallow();
