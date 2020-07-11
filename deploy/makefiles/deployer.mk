# API
#########################

# make unlock-local
# make unlock-remote
# make setup-dev
# make update-dev
# make populate-dev
# make setup-test
# make setup-local-staging
# make build
# make setup-remote-app-staging
# make setup-remote-app-prod
# make deploy-staging
# make deploy-prod
# make rollback-staging
# make rollback-prod

# Functions
#########################

define dep
	@docker exec -it php sh -c 'cd $${DEPLOY_PATH} && dep $(1) -$${VERBOSITY} $(2)'
endef

# Targets
#########################

# LOCAL
unlock-local: up-build
	$(call dep, deploy:unlock:local) || echo "Deployer target 'deploy:unlock:local' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: unlock-local

# REMOTE
unlock-remote: up-build
	$(call dep, deploy:unlock) || echo "Deployer target 'deploy:unlock' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: unlock-remote

#########################

# LOCAL
setup-dev:
	$(call env,dev)
	@$(MAKE) -f $(THIS_FILE) down-dev
	@echo -n "Your development repo /sylius/dev must be empty and world writable \n"
	@echo -n "Do you want to continue? [y/N] " && read ans && [ $${ans:-N} = y ]
	@$(MAKE) -f $(THIS_FILE) up-dev
	$(call dep, setup_dev) || echo "Deployer target 'setup_dev' failed"
	@$(MAKE) -f $(THIS_FILE) down-dev
.PHONY: setup-dev

# LOCAL
update-dev:
	$(call env,dev)
	@$(MAKE) -f $(THIS_FILE) down-dev
	@echo -n "Your development repo /sylius/dev must be empty and world writable \n"
	@echo -n "Do you want to continue? [y/N] " && read ans && [ $${ans:-N} = y ]
	@$(MAKE) -f $(THIS_FILE) up-dev
	$(call dep, update_dev) || echo "Deployer target 'update_dev' failed"
	@$(MAKE) -f $(THIS_FILE) down-dev
.PHONY: update-dev

# LOCAL
populate-dev:
	$(call env,dev)
	@echo -n "Your database will be droped and repopulated \n"
	@echo -n "Do you want to continue? [y/N] " && read ans && [ $${ans:-N} = y ]
	@$(MAKE) -f $(THIS_FILE) up-dev
	$(call dep, populate_dev) || echo "Deployer target 'populate_dev' failed"
	@$(MAKE) -f $(THIS_FILE) down-dev
.PHONY: populate-dev

#########################

# LOCAL
setup-test: up-test
	$(call dep, setup_test) || echo "Deployer target 'setup_test' failed"
	@$(MAKE) -f $(THIS_FILE) down-test
.PHONY: setup-test

#########################

# LOCAL
setup-local-staging:
	$(call env,local-staging)
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, setup_local_staging) || echo "Deployer target 'setup_local_staging' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: setup-local-staging

#########################

# LOCAL (Production)
build:
	$(call env,build)
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, build) || echo "Deployer target 'build' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: build

#########################

# REMOTE
setup-remote-app-staging:
	$(call env,remote-staging)
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, setup_prod) || echo "Deployer target 'setup_prod' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: setup-remote-app-staging

# REMOTE
setup-remote-app-prod:
	$(call env,prod)
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, setup_prod) || echo "Deployer target 'setup_prod' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: setup-remote-app-prod

#########################

# REMOTE
deploy-staging:
	$(call env,remote-staging)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/update-remote-env.sh ;
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, deploy) || echo "Deployer target 'deploy' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: deploy-staging

# REMOTE
deploy-prod:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/update-remote-env.sh ;
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, deploy) || echo "Deployer target 'deploy' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: deploy-prod

# REMOTE
rollback-staging:
	$(call env,remote-staging)
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, rollback) || echo "Deployer target 'rollback' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: rollback

# REMOTE
rollback-prod:
	$(call env,prod)
	@$(MAKE) -f $(THIS_FILE) up-build
	$(call dep, rollback) || echo "Deployer target 'rollback' failed"
	@$(MAKE) -f $(THIS_FILE) down-build
.PHONY: rollback