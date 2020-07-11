<?php

namespace Deployer;

/**
 * Override default composer_options to include --no-dev
 */
set('composer_options', function () {
    $nodev = '';
    if (get('app_env') === 'prod') {
        $nodev = '--no-dev';
    }

    return '{{composer_action}} --verbose --prefer-dist --no-progress --no-interaction '.$nodev.' --optimize-autoloader --no-suggest';
});

/**
 * Configure composer
 *
 * - Set github oauth token to avoid quota warnings
 */
desc('Configuring composer');
task('sylius:composer:configure', function () {
    if (get('github_oauth_token') !== false) {
        run('cd {{release_path}} && {{bin/composer}} config --auth github-oauth.github.com '.get('github_oauth_token'));
    }
});

/**
 * Composer dump-autoload
 */
desc('Composer dump-autoload');
task('sylius:composer:dump_autoload', function () {
    if (get('app_env') !== 'dev') {
        run('cd {{release_path}} && {{bin/composer}} dump-autoload --optimize --apcu');
    }
});

/**
 * Composer dump-env
 */
desc('Composer dump-env');
task('sylius:composer:dump_env', function () {
    if (get('app_env') !== 'dev') {
        run('cd {{release_path}} && {{bin/composer}} dump-env {{app_env}}');
    }
});
