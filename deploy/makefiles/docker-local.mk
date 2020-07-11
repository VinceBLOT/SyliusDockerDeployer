# API
#########################

# make mailhog
# make adminer
# make kibana
# make chrome-headless
# make selenium-chrome
# make memcached

# make env-[dev|test|build|local-staging|remote-staging|prod]
# make build-[dev|test|local-staging|remote-staging|prod] [service=service-name]
# make pull-[dev|test|local-staging] [service=service-name]
# make up-[dev|test|build|local-staging] [service=service-name]
# make reload-[dev|test|local-staging] [service=service-name]
# make down-[dev|test|build|local-staging] [service=service-name]

# Targets
#########################

mailhog:
	$(call sh,mailhog)
.PHONY: mailhog
adminer:
	$(call sh,adminer)
.PHONY: adminer
kibana:
	$(call sh,kibana)
.PHONY: kibana
chrome-headless:
	$(call sh,chrome-headless)
.PHONY: chrome-headless
selenium-chrome:
	$(call sh,selenium-chrome)
.PHONY: selenium-chrome
memcached:
	$(call sh,memcached)
.PHONY: memcached

#########################

env-dev:
	$(call env,dev)
.PHONY: env-dev
build-dev: env-dev
	$(call compose,build,dev,$(service))
.PHONY: build-dev
pull-dev: env-dev
	$(call compose,pull,dev,$(service))
.PHONY: pull-dev
up-dev: env-dev
	$(call compose,up,dev,$(service))
.PHONY: up-dev
reload-dev: env-dev
	$(call compose,reload,dev,$(service))
.PHONY: reload-dev
down-dev:
	$(call compose,down,dev,$(service))
.PHONY: down-dev

#########################

env-test:
	$(call env,test)
.PHONY: env-test
build-test: env-test
	$(call compose,build,test,$(service))
.PHONY: build-test
pull-test: env-test
	$(call compose,pull,test,$(service))
.PHONY: pull-test
up-test: env-test
	$(call compose,up,test,$(service))
.PHONY: up-test
reload-test: env-test
	$(call compose,reload,test,$(service))
.PHONY: reload-test
down-test:
	$(call compose,down,test,$(service))
.PHONY: down-test

#########################

env-build:
	$(call env,build)
.PHONY: env-build
up-build:
	$(call compose,up,build,$(service))
.PHONY: up-build
down-build:
	$(call compose,down,build,$(service))
.PHONY: down-build

#########################

env-local-staging:
	$(call env,local-staging)
.PHONY: env-local-staging
build-local-staging: env-local-staging
	$(call compose,build,local-staging,$(service))
.PHONY: build-local-staging
pull-local-staging: env-local-staging
	$(call compose,pull,local-staging,$(service))
.PHONY: pull-local-staging
up-local-staging: env-local-staging
	$(call compose,up,local-staging,$(service))
.PHONY: up-local-staging
reload-local-staging: env-local-staging
	$(call compose,reload,local-staging,$(service))
.PHONY: reload-local-staging
down-local-staging:
	$(call compose,down,local-staging,$(service))
.PHONY: down-local-staging

#########################

# Just env (everything else is prod on remote host)
env-remote-staging:
	$(call env,remote-staging)
.PHONY: env-remote-staging

# Alias to "build-prod" as "*-remote-staging" is "*-prod" on
# remote host.
build-remote-staging: build-prod
.PHONY: build-prod

#########################

# Only env and build on local (everything else is on Makefile.prod)
env-prod:
	$(call env,prod)
.PHONY: env-prod

build-prod: env-prod
	$(call compose,build,prod,$(service))
.PHONY: build-prod
