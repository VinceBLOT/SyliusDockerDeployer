<?php

namespace Deployer;

/**
 * Drop database
 */
desc('Drop database');
task('sylius:database:drop', function () {
    runService('php', '{{bin/console}} doctrine:database:drop --if-exists --force');
});

/**
 * Create database
 */
desc('Create database');
task('sylius:database:create', function () {
    runService('php', '{{bin/console}} doctrine:database:create --if-not-exists');
});

/**
 * Initial database setup
 *
 * Setup:
 *   Channel
 *   Currency
 *   Locale
 *   Admin account:
 *     user:sylius@example.com
 *     password: sylius
 *
 * Fixtures:
 *
 * Dump:
 *
 * Warning: Do not allocate tty
 */
desc('Populate database');
task('sylius:database:populate', function () {
    $data = get('populate_database');
    if ($data === 'setup') {
        runService('php', '{{bin/console}} sylius:install:setup');
    } elseif ($data === 'fixtures') {
        runService('php', '{{bin/console}} sylius:fixtures:load');
    } elseif ($data === 'dump') {
    }
});

/**
 * Migrations
 */

/**
 * Initialize migrations log file
 */
desc('Create metadata migrations file');
task('sylius:migrations:prepare', function () {
    run('cd {{deploy_path}}/.dep && if [ ! -f migrations ]; then touch migrations; fi');
});

/**
 * Log release / migration version pair
 *
 * This task should be called ALWAYS after deploy:release
 * and before deploy:symlink otherwise release number
 * won't match.
 *
 * release_name throws current release +1, and we want
 * current release. Hence the get('release_name') - 1
 */
desc('Set current release / migration version pair');
task('sylius:migrations:log_version', function () {
    if (get('app_env') === 'prod') {
        $release = (string) ((int) get('release_name') - 1);
        $migration = runService('php', '{{bin/console}} doctrine:migrations:latest');
        $line = $release.','.$migration;
        run('cd {{deploy_path}}/.dep && if [ -f migrations ]; then printf "%s\n" "'.$line.'" >> migrations; fi');
    }
});

/**
 * Migration command
 *
 * The "allow-no-migration" parameter tells doctrine to not
 * throw an exception when there is nothing to do.
 *
 * When using the "all_or_nothing" option, multiple migrations
 * ran at the same time will be wrapped in a single transaction.
 * If one migration fails, all migrations will be rolled back.
 */
desc('Migrate database');
task('sylius:migrations:migrate', function () {
    runService('php', '{{bin/console}} doctrine:migrations:migrate --allow-no-migration --all-or-nothing');
});

/**
 * Rollback command
 *
 * In a migration rollback scenario, we need to know
 * to what migration version we should downgrade.
 *
 * release_name throws current release +1, and we want
 * current release -1 (previous). Hence the get('release_name') - 2
 */
desc('Rollback database migration');
task('sylius:migrations:rollback', function () {
    $file = run('cd {{deploy_path}}/.dep && if [ -f migrations ];then cat migrations; fi');
    $list = array_unique(explode(PHP_EOL, $file));

    // Get all version,migration points
    foreach ($list as $line) {
        $entry = explode(',', $line);
        $migrations[$entry[0]] = $entry[1];
    }
    $migrations = array_reverse($migrations, true);

    // Migrate based on target release and associated migration version
    $release = (int) get('release_name') - 2;
    $version = $migrations[$release] ?? 0;
    runService('php', '{{bin/console}} doctrine:migrations:migrate --version '.$version.'');

    // Remove current release,migration point from log file
    $current = (int) get('release_name') - 1;
    unset($migrations[$current]);
    foreach ($migrations as $rel => $mig) {
        $updatedList[] = $rel.','.$mig;
    }
    $updatedList = array_reverse($updatedList, true);
    run('cd {{deploy_path}}/.dep && if [ -f migrations ]; then printf "%s\n" "'.implode(PHP_EOL, $updatedList).'" > migrations; fi');
});

/**
 * Backup
 */

/**
 * Clear doctrine cache
 */
desc('Clear doctrine cache');
task('sylius:doctrine:cache:clear', function () {
    runService('php', '{{bin/console}} doctrine:cache:clear-metadata');
    runService('php', '{{bin/console}} doctrine:cache:clear-query');
    runService('php', '{{bin/console}} doctrine:cache:clear-result');
});

/**
 * Wrapper to mysqldump backup script
 */
desc('Backup database');
task('sylius:database:backup', function () {
    // ...
});

/**
 * Wrapper to mysql restore script
 */
desc('Restore database');
task('sylius:database:restore', function () {
    // https://www.cyberciti.biz/faq/unpacking-or-uncompressing-gz-files/
    // gunzip database.sql.gzip
    // runService('php', '{{bin/console}} doctrine:database:import ...');
});
