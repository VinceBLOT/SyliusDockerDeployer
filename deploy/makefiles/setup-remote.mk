# API
#########################

# Targets not intended to be called directly.
# They are designed to be called on build server
# and run on remote server.

# make setup-filesystem
# make setup-ssl-dry
# make setup-ssl
# make setup-database-backup
# make setup-logrotate

# Targets
#########################

setup-filesystem:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-filesystem.sh ;
.PHONY: setup-filesystem

setup-ssl-dry:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-ssl.sh dry;
.PHONY: setup-ssl-dry

setup-ssl:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-ssl.sh prod;
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-ssl-cron.sh ;
.PHONY: setup-ssl

setup-database-backup:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-database-backup-cron.sh ;
.PHONY: setup-database-backup

setup-logrotate:
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/setup-logrotate-cron.sh ;
.PHONY: setup-logrotate
