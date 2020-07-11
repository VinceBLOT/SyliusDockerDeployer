<?php

namespace Deployer;

/**
 * Reload the php (php-fpm) process
 *
 * To refresh opcache we need to reload php-fpm process.
 */
desc('Reload the php-fpm process');
task('sylius:php:restart', function () {
    runService('php', get('php_fpm_restart_command'));
});
