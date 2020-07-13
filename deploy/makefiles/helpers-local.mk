# API
#########################

# make run-tests
# make set-staging-maintenance-on
# make set-staging-maintenance-off
# make set-prod-maintenance-on
# make set-prod-maintenance-off
# make run-remote-database-backup

# Targets
#########################

run-tests:
	$(call env,test)
	@$(MAKE) -f $(THIS_FILE) up-test
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/run-tests.sh || echo "Test suite failed"
	@$(MAKE) -f $(THIS_FILE) down-test
.PHONY: run-tests

set-staging-maintenance-on:
	$(call env,remote-staging)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-remote-maintenance.sh on ;
.PHONY: set-staging-maintenance-on

set-staging-maintenance-off:
	$(call env,remote-staging)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-remote-maintenance.sh off ;
.PHONY: set-staging-maintenance-off

set-prod-maintenance-on:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-remote-maintenance.sh on ;
.PHONY: set-prod-maintenance-on

# Only on prod
set-prod-maintenance-off:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-remote-maintenance.sh off ;
.PHONY: set-prod-maintenance-off

# Only on prod
run-remote-database-backup:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/run-remote-database-backup.sh ;
.PHONY: run-remote-database-backup
