.PHONY: help list build up down clean start status ps stop logs cli client sh bash shell

APP_NAME := openhab

DOCKER         := sudo docker
DOCKER_COMPOSE := sudo docker-compose

CMD_CLIENT    := /openhab/runtime/bin/client
CMD_SHELL     := /bin/bash

.DEFAULT_GOAL := help

ME  := $(realpath $(firstword $(MAKEFILE_LIST)))
PWD := $(dir $(ME))

##
# help
# Displays list of targets, using target '##' comments as descriptions
# NOTE: Keep 'help' as first target in case .DEFAULT_GOAL is not honored
#
help:      ## This help screen
	@echo
	@echo  "Make targets:"
	@echo
	@cat $(ME) | \
	sed -n -r 's/^([^.][^: ]+)\s*:(([^=#]*##\s*(.*[^[:space:]])\s*)|[^=].*)$$/    \1\t\4/p' | \
	sort -u | \
	expand -t15
	@echo

##
# list
# We place 'list' after 'help' to keep 'help' as first target
#
list: help ## List targets (currently an alias for 'help')

##
# build
#
build: ## Build the app, ignoring cache
	$(DOCKER_COMPOSE) build --no-cache

##
# up
#
up: ## Launch the app in detached mode
	$(DOCKER_COMPOSE) up --detach

##
# down
#
down: ## Stop the app, destroying the container, but preserving images and volumes
	$(DOCKER_COMPOSE) down

##
# clean
#
clean: ## Stop the app, destroying the container, images and volumes
	$(DOCKER_COMPOSE) down --volumes --rmi all

##
# start
#
start: ## Start a stopped app
	$(DOCKER_COMPOSE) start

##
# ps
#
status: ps ## Alias for 'ps'
ps:        ## Show app status
	$(DOCKER_COMPOSE) ps

##
# stop
#
stop: ## Stop a running app, without destroying it
	$(DOCKER_COMPOSE) stop

##
# logs
#
logs:  ## View output of a running app
	$(DOCKER_COMPOSE) logs --follow

##
# client
#
cli:    cli ## Alias for 'client'
client:     ## Run OpenHAB Client
	$(DOCKER) exec -it  $(APP_NAME) $(CMD_CLIENT)

##
# shell
#
sh:    shell ## Alias for 'shell'
bash:  shell ## Alias for 'shell' (may not actually be bash)
shell:       ## Access shell in app container
	$(DOCKER) exec -it $(APP_NAME) $(CMD_SHELL)
