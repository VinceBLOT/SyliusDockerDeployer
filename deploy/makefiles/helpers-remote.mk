# API
#########################

# Targets not intended to be called directly.
# They are designed to be called on build server
# and run on remote server.

# make renew-ssl
# make run-database-backup
# make run-logrotate

# Targets
#########################

renew-ssl:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/renew-ssl.sh ;
.PHONY: renew-ssl

run-database-backup:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/run-database-backup.sh ;
.PHONY: run-database-backup

run-logrotate:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/run-logrotate.sh ;
.PHONY: run-logrotate
