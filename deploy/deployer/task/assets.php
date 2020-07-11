<?php

namespace Deployer;

/**
 * Install frontend assets via Gulp and Encore
 */
desc('Install frontend assets via yarn');
task('sylius:assets', function () {

    // "yarn" and "yarn install" install packages from yarn.lock.
    // https://classic.yarnpkg.com/en/docs/cli/install/#toc-yarn-install
    run('cd {{release_path}} && yarn install');

    // Copy assets to public folder
    run('cd {{release_path}} && {{bin/console}} assets:install public');
    run('cd {{release_path}} && {{bin/console}} sylius:theme:assets:install public');

    // Gulp
    if (test('[ -f "{{release_path}}/gulpfile.babel.js" ]')) {
        // runs "build" command on "package.json" which is "gulp build".
        run('cd {{release_path}} && yarn build');
    }

    // Encore
    if (test('[ -f "{{release_path}}/webpack.config.js" ]')) {
        $env = 'dev';
        if (get('app_env') === 'prod') {
            $env = 'production';
        }
        run('cd {{release_path}} && yarn encore ' . $env);
    }
});
