# API
#########################

# make build-prod [service=service-name]
# make pull-prod [service=service-name]
# make up-prod [service=service-name]
# make reload-prod [service=service-name]
# make down-prod [service=service-name]
# make cleanup-prod

# Targets
#########################

build-prod:
	$(call compose,build,prod,$(service))
.PHONY: build-prod
pull-prod:
	$(call compose,pull,prod,$(service))
.PHONY: pull-prod
up-prod:
	$(call compose,up,prod,$(service))
.PHONY: up-prod
reload-prod:
	$(call compose,reload,prod,$(service))
.PHONY: reload-prod
down-prod:
	$(call compose,down,prod,$(service))
.PHONY: down-prod
cleanup-prod:
	@docker system prune -a -f
.PHONY: cleanup-prod
