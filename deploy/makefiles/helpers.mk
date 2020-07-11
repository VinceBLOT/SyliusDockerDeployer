# API
#########################

# make set-maintenance-on
# make set-maintenance-off

# Targets
#########################

set-maintenance-on:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-maintenance.sh on ;
.PHONY: set-maintenance-on

set-maintenance-off:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/set-maintenance.sh off ;
.PHONY: set-maintenance-off