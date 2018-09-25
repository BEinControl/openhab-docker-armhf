.PHONY: build up start ps status stop down clean logs client bash

APP_NAME := openhab

DOCKER         := sudo docker
DOCKER_COMPOSE := sudo docker-compose

CMD_CLIENT    := /openhab/runtime/bin/client
CMD_BASH      := /bin/bash

build:
	$(DOCKER_COMPOSE) build --no-cache

up:
	$(DOCKER_COMPOSE) up --detach

down:
	@echo "Target 'down' disabled.  Use 'stop' stop the container, or 'clean' to destroy it"

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
	$(DOCKER_COMPOSE) logs

client:
	$(DOCKER) exec -it  $(APP_NAME) $(CMD_CLIENT)

bash:
	$(DOCKER) exec -it $(APP_NAME) $(CMD_BASH)
