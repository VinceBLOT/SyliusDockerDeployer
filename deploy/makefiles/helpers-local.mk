# API
#########################

# make run-tests
# make set-remote-maintenance-on
# make set-remote-maintenance-off
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

# Only on prod
set-remote-maintenance-on:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-remote-maintenance.sh on ;
.PHONY: set-remote-maintenance-on

# Only on prod
set-remote-maintenance-off:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-remote-maintenance.sh off ;
.PHONY: set-remote-maintenance-off

# Only on prod
run-remote-database-backup:
	$(call env,prod)
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/run-remote-database-backup.sh ;
.PHONY: run-remote-database-backup
