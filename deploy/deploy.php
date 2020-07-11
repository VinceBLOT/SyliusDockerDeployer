<?php

namespace Deployer;

require 'recipe/common.php';

/* Config */
require __DIR__.'/deployer/config/config.php';

/* Helpers */
require __DIR__.'/deployer/functions/functions.php';

/* Tasks */
require __DIR__.'/deployer/task/assets.php';
require __DIR__.'/deployer/task/build.php';
require __DIR__.'/deployer/task/cache.php';
require __DIR__.'/deployer/task/composer.php';
require __DIR__.'/deployer/task/database.php';
require __DIR__.'/deployer/task/elasticsearch.php';
require __DIR__.'/deployer/task/lock.php';
require __DIR__.'/deployer/task/maintenance.php';
require __DIR__.'/deployer/task/message.php';
require __DIR__.'/deployer/task/php.php';
require __DIR__.'/deployer/task/rollback.php';
require __DIR__.'/deployer/task/varnish.php';

/* Macros */
require __DIR__.'/deployer/macro/build.php';
require __DIR__.'/deployer/macro/migrate.php';
require __DIR__.'/deployer/macro/populate.php';
require __DIR__.'/deployer/macro/post_build.php';
require __DIR__.'/deployer/macro/pre_release.php';
require __DIR__.'/deployer/macro/refresh.php';
require __DIR__.'/deployer/macro/release.php';
require __DIR__.'/deployer/macro/setup_db.php';
require __DIR__.'/deployer/macro/upload.php';

/* Recipes */
require __DIR__.'/deployer/recipe/build.php';
require __DIR__.'/deployer/recipe/deploy.php';
require __DIR__.'/deployer/recipe/setup_dev.php';
require __DIR__.'/deployer/recipe/populate_dev.php';
require __DIR__.'/deployer/recipe/update_dev.php';
require __DIR__.'/deployer/recipe/setup_prod.php';
require __DIR__.'/deployer/recipe/rollback.php';
require __DIR__.'/deployer/recipe/setup_local_staging.php';
require __DIR__.'/deployer/recipe/setup_test.php';

after('deploy:failed', 'sylius:message:fail');
