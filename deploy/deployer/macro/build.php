<?php

namespace Deployer;

/**
 * Build
 *
 * Build release on local build server.
 *
 * Warnings:
 *   - Do not call deploy:shared on build, it must be called
 *     separately (only on remote).
 *   - Only call deploy:writable at the very end.
 */
task('macro:build', [
    'deploy:update_code',
    'sylius:composer:configure',
    'deploy:vendors',
    'sylius:assets',
    'sylius:cache:clear',
    'sylius:cache:warmup',
    'sylius:composer:dump_autoload',
    'sylius:composer:dump_env',
    'deploy:writable',
])->shallow();

/**
 * This fail is always triggered before deploy:symlink,
 * and also before any database migration has taken effect,
 * so there is no need to fix anything, because in the next
 * deploy, deploy:release will remove failed release folder. 
 * So we only need to remove lock file.
 */
fail('macro:build', 'sylius:lock:unlock_local');
