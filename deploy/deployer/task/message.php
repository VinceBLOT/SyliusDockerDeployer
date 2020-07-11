<?php

namespace Deployer;

/**
 * Failure message
 */
desc('Failure message');
task('sylius:message:fail', function () {
    writeln('{{fail_message}}');
})
    ->local()
    ->shallow()
    ->setPrivate();
