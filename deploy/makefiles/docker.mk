# API
#########################

# make proxy
# make varnish
# make nginx
# make php
# make mysql
# make elasticsearch

# Functions
#########################

define env
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/compile-env.sh $(1);
endef

define compose
	@cd $(THIS_PATH) ;\
	export STACK_PATH=$(THIS_PATH) ;\
	./deploy/scripts/compile-compose-call.sh $(1) $(2) $(3);
endef

define sh
	@docker exec -it $(1) /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"
endef

# Targets
#########################

proxy:
	$(call sh,proxy)
.PHONY: proxy
varnish:
	$(call sh,varnish)
.PHONY: varnish
nginx:
	$(call sh,nginx)
.PHONY: nginx
php:
	$(call sh,php)
.PHONY: php
mysql:
	$(call sh,mysql)
.PHONY: mysql
elasticsearch:
	$(call sh,elasticsearch)
.PHONY: elasticsearch
