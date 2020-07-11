<?php

namespace Deployer;

/**
 * Run command inside docker container or directly on host
 * based on is_dockerized config parameter.
 *
 * @param string $service Docker service to run command on
 */
function runService(string $service, string $command, $options = []): string
{
    if (get('is_dockerized') === true) {
        return run('docker exec '.$service.' sh -c "'.$command.'"', $options);
    }

    return run($command, $options);
}
