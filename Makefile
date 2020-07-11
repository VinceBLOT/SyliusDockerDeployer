.DEFAULT_GOAL := help
THIS_FILE := $(lastword $(MAKEFILE_LIST))
THIS_PATH :=$(abspath $(dir $(lastword $(MAKEFILE_LIST))))

help:
	@echo ''
	@echo 'Usage: make [TARGET] [EXTRA_ARGUMENTS]'
	@echo ''

	@echo 'Setup targets:'
	@echo '  setup-local-stack'
	@echo '  setup-remote-stack-staging-keys'
	@echo '  setup-remote-stack-staging'
	@echo '  setup-remote-stack-staging-ssl-dry'
	@echo '  setup-remote-stack-staging-ssl'
	@echo '  setup-remote-stack-prod-keys'
	@echo '  setup-remote-stack-prod'
	@echo '  setup-remote-stack-prod-ssl-dry'
	@echo '  setup-remote-stack-prod-ssl'
	@echo '  setup-remote-database-backup'
	@echo '  setup-remote-logrotate'
	@echo ''

	@echo 'Deployer targets:'
	@echo '  unlock-local'
	@echo '  unlock-remote'
	@echo '  setup-dev'
	@echo '  update-dev'
	@echo '  populate-dev'
	@echo '  setup-test'
	@echo '  setup-local-staging'
	@echo '  build'
	@echo '  setup-remote-app-staging'
	@echo '  setup-remote-app-prod'
	@echo '  deploy-staging'
	@echo '  deploy-prod'
	@echo '  rollback-staging'
	@echo '  rollback-prod'
	@echo ''

	@echo 'Docker targets:'
	@echo '  env-[dev|test|build|local-staging|remote-staging|prod]'
	@echo '  build-[dev|test|local-staging|remote-staging|prod] [service=service-name]'
	@echo '  pull-[dev|test|local-staging] [service=service-name]'
	@echo '  up-[dev|test|build|local-staging] [service=service-name]'
	@echo '  reload-[dev|test|local-staging] [service=service-name]'
	@echo '  down-[dev|test|build|local-staging] [service=service-name]'
	@echo ''

	@echo 'Docker services targets:'
	@echo '  proxy'
	@echo '  varnish'
	@echo '  nginx'
	@echo '  php'
	@echo '  mysql'
	@echo '  elasticsearch'
	@echo '  mailhog'
	@echo '  adminer'
	@echo '  kibana'
	@echo '  chrome-headless'
	@echo '  selenium-chrome'
	@echo '  memcached'
	@echo ''

	@echo 'Helper targets:'
	@echo '  run-tests'
	@echo '  set-maintenance-on'
	@echo '  set-maintenance-off'
	@echo '  set-remote-maintenance-on'
	@echo '  set-remote-maintenance-off'
	@echo '  run-remote-database-backup'
	@echo ''

.PHONY: help

include $(THIS_PATH)/deploy/makefiles/deployer.mk
include $(THIS_PATH)/deploy/makefiles/docker.mk
include $(THIS_PATH)/deploy/makefiles/docker-local.mk
include $(THIS_PATH)/deploy/makefiles/helpers.mk
include $(THIS_PATH)/deploy/makefiles/helpers-local.mk
include $(THIS_PATH)/deploy/makefiles/setup-local.mk
