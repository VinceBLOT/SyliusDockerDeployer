<?php

namespace Deployer;

/**
 * Create builds dir
 */
desc('Create builds dir');
task('sylius:build:prepare', function () {
    run('cd {{deploy_path}} && if [ ! -d builds ]; then mkdir builds; fi');
});

/**
 * Create tar from latest release
 */
desc('Create tar from latest release');
task('sylius:build:tar', function () {
    $target = run('readlink "{{deploy_path}}/release"');
    run('tar -czvf "{{deploy_path}}/builds/latest.tar" -C "'.$target.'/" .');
});

/**
 * Upload latest release
 */
desc('Upload latest release');
task('sylius:build:upload', function () {
    upload('{{deploy_path}}/builds/latest.tar', '{{deploy_path}}/builds/latest.tar');
    $target = run('readlink "{{deploy_path}}/release"');
    run('tar -xzvf "{{deploy_path}}/builds/latest.tar" --directory "{{deploy_path}}/'.$target.'"');
});
