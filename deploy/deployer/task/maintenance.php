<?php

namespace Deployer;

/**
 * Maintenance mode on
 */
desc('Enable maintenance mode');
task('sylius:maintenance:on', function () {
    $result = run('cd {{maintenance_path}} && if [ -f maintenance_off.html ]; then mv maintenance_off.html maintenance_on.html && echo done; fi');
    if ($result === 'done') {
        writeln('<fg=yellow>Maintenance mode ON</fg=yellow>');
    }
})->shallow();

/**
 * Maintenance mode off
 */
desc('Disable maintenance mode');
task('sylius:maintenance:off', function () {
    $result = run('cd {{maintenance_path}} && if [ -f maintenance_on.html ]; then mv maintenance_on.html maintenance_off.html && echo done; fi');
    if ($result === 'done') {
        writeln('<fg=cyan>Maintenance mode OFF</fg=cyan>');
    }
})->shallow();
