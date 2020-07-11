# API
#########################

# make setup-local-stack
# make setup-remote-stack-staging-keys
# make setup-remote-stack-staging
# make setup-remote-stack-staging-ssl-dry
# make setup-remote-stack-staging-ssl
# make setup-remote-stack-prod-keys
# make setup-remote-stack-prod
# make setup-remote-stack-prod-ssl-dry
# make setup-remote-stack-prod-ssl
# make setup-remote-database-backup
# make setup-remote-logrotate

# Targets
#########################

# LOCAL DEV

setup-local-stack:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-filesystem.sh ;
	$(call env,dev)
.PHONY: setup-local-stack

#########################

# REMOTE STAGING

setup-remote-stack-staging-keys:
	$(call env,remote-staging)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-keys.sh ;
.PHONY: setup-remote-stack-staging-keys

setup-remote-stack-staging:
	@echo -n "Your remote staging stack will be deleted \n"
	@echo -n "Do you want to continue? [y/N] " && read ans && [ $${ans:-N} = y ]
	$(call env,remote-staging)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-host.sh override;
.PHONY: setup-remote-stack-staging

setup-remote-stack-staging-ssl-dry:
	$(call env,remote-staging)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-ssl.sh dry;
.PHONY: setup-remote-stack-staging-ssl-dry

setup-remote-stack-staging-ssl:
	$(call env,remote-staging)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-ssl.sh prod;
.PHONY: setup-remote-stack-staging-ssl

#########################

# REMOTE PROD

setup-remote-stack-prod-keys:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-keys.sh ;
.PHONY: setup-remote-stack-prod-keys

setup-remote-stack-prod:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-host.sh ;
.PHONY: setup-remote-stack-prod

setup-remote-stack-prod-ssl-dry:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-ssl.sh dry;
.PHONY: setup-remote-stack-prod-ssl-dry

setup-remote-stack-prod-ssl:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-ssl.sh prod;
.PHONY: setup-remote-stack-prod-ssl

#########################

# REMOTE PROD

# Only on prod
setup-remote-database-backup:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-database-backup.sh ;
.PHONY: setup-remote-database-backup

# Only on prod
setup-remote-logrotate:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-remote-logrotate.sh ;
.PHONY: setup-remote-logrotate
