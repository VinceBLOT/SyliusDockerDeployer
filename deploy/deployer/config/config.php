<?php

declare(strict_types=1);

namespace Deployer;

/**
 * Defaults overrides
 */
set('allow_anonymous_stats', false);
set('default_stage', 'prod');
set('default_timeout', 600);
set('http_user', getenv('LOCAL_USER_UID'));
set('keep_releases', 2);
set('writable_mode', 'acl');
set('writable_recursive', true);

/**
 * Infra
 */
set('fail_message', '<fg=red>Unexpected fail while deploying to {{target}}. Manual intervention probably would be required.</fg=red>');
set('is_dockerized', true);
// https://www.cyberciti.biz/faq/how-to-reload-restart-php7-0-fpm-service-linux-unix/
set('php_fpm_restart_command', 'kill -USR2 1');
set('stack_repo', getenv('STACK_REPO'));
set('with_elasticsearch', (bool) getenv('WITH_ELASTICSEARCH'));
set('with_varnish', (bool) getenv('WITH_VARNISH'));

/**
 * App
 */
set('app_env', getenv('APP_ENV'));
set('branch', getenv('APP_BRANCH')); // This disables dep deploy --branch=...
set('github_oauth_token', getenv('GITHUB_OAUTH_TOKEN'));
set('populate_database', getenv('POPULATE_DATABASE'));
set('repository', getenv('APP_REPO'));

/**
 * Filesystem paths
 */
set('deploy_path', getenv('APP_DEPLOYMENT_PATH'));
set('maintenance_path', getenv('MAINTENANCE_PATH'));
set('static_release_path', getenv('APP_CURRENT_RELEASE_PATH'));
set('clear_paths', [
    'docker',
    'features',
    'node_modules',
    'tests',
    '.git',
    '.github',

    // All but .env* and composer.json
    'auth.json',
    'behat.yml',
    'behat.yml.dist',
    'composer.lock',
    'docker-compose.prod.yml',
    'docker-compose.yml',
    'Dockerfile',
    'easy-coding-standard.yml',
    'gulpfile.babel.js',
    'LICENSE',
    'package.json',
    'phpcs.xml',
    'phpmd.xml',
    'phpspec.yaml.dist',
    'phpstan.neon',
    'psalm.xml',
    'README.md',
    'symfony.lock',
    'themes.json',
    'webpack.config.js',
    'yarn.lock',
    '.babelrc',
    '.dockerignore',
    '.editorconfig',
    '.eslintrc.js',
    '.gitignore',
    '.php_cs',
    '.travis.yml',
]);
set('shared_dirs', [
    'public/media',
    ]);
set('shared_files', []);
set('writable_dirs', [
    'etc/build',
    'public/media',
    // Needed to change theme on production
    'var/cache',
]);

/**
 * Custom bins
 */
set('verbosity', getenv('VERBOSITY'));
set('bin/console', function () {
    return parse('php {{release_path}}/bin/console --no-interaction -{{verbosity}}');
});

/**
 * Hosts
 */
host(getenv('HOST_IP'))
    ->stage('prod')
    ->user(getenv('REMOTE_USER'))
    ->port((int) getenv('REMOTE_PORT'))
    ->forwardAgent(true)
    ->identityFile(getenv('SSH_KEYS_PATH').'/'.getenv('REMOTE_IDENTITY'))
    ->addSshOption('UserKnownHostsFile', '/dev/null')
    ->addSshOption('StrictHostKeyChecking', 'no')
    ->set('cleanup_use_sudo', ((bool) getenv('USE_SUDO') === true) ? true : false)
    ->set('clear_use_sudo', ((bool) getenv('USE_SUDO') === true) ? true : false)
    ->set('writable_use_sudo', ((bool) getenv('USE_SUDO') === true) ? true : false);
