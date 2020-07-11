<?php

namespace Deployer;

/**
 * Clean rollback
 *
 * A clean rollback is only triggered after a successful
 * deployment. So is always run after a successful migration
 * also.
 */
task('rollback', [
    'deploy:lock',
    'sylius:maintenance:on',
    // executed on current release:
    'sylius:doctrine:cache:clear',
    'sylius:migrations:rollback',
    // rollback to previous release:
    'rollback',
    // Needed to point /release symlink to
    // previous release (now current):
    'rollback:remove_release_symlink',
    // executed on previous (now current) release:
    'macro:refresh',
    'deploy:unlock',
    'sylius:maintenance:off',
])->shallow();

after('rollback', 'success');
fail('rollback', 'deploy:failed');
