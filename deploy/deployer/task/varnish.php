<?php

namespace Deployer;

/**
 * Varnish purge
 */
desc('Purge varnish cache');
task('sylius:varnish:purge', function () {
    if (get('with_varnish') === true) {
        // runService('varnish', '...');
    }
});
