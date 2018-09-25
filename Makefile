.PHONY: build up down clean start ps status stop logs cli client sh shell bash

APP_NAME := openhab

DOCKER         := sudo docker
DOCKER_COMPOSE := sudo docker-compose

CMD_CLIENT    := /openhab/runtime/bin/client
CMD_SHELL     := /bin/bash

build:
	$(DOCKER_COMPOSE) build --no-cache

up:
	$(DOCKER_COMPOSE) up --detach

down:
	$(DOCKER_COMPOSE) down

clean:
	$(DOCKER_COMPOSE) down --volumes --rmi all

start:
	$(DOCKER_COMPOSE) start

status: ps
ps:
	$(DOCKER_COMPOSE) ps

stop:
	$(DOCKER_COMPOSE) stop

logs:
	$(DOCKER_COMPOSE) logs --follow

client: cli
cli:
	$(DOCKER) exec -it  $(APP_NAME) $(CMD_CLIENT)

shell: sh
bash: sh
sh:
	$(DOCKER) exec -it $(APP_NAME) $(CMD_SHELL)
