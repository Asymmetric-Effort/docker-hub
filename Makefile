DOCKER_HUB:=docker.internal.asymmetric-effort.com
DOCKER_HUB_DOCKER_IMAGE_NAME:=asymmetric-effort/docker-hub:local
DOCKER_HUB_DOCKER_CONTAINER_NAME:=docker-hub
DOCKER_HUB_IP_ADDRESS:=10.37.129.2
DOCKER_HUB_PORT:=8125
DOCKER_HUB_VOLUME:=$(HOME)/docker_hub
DOCKER_HUB_VERSION:=0.0.0
DOCKER_HUB_REGISTRY_HTTP_SECRET:=cpe-1704-tks

DOCKER_REDIS_IMAGE:=redis:latest
DOCKER_REDIS_CONTAINER_NAME:=docker-cache-redis
DOCKER_REDIS_IP_ADDRESS:=10.37.129.2
DOCKER_REDIS_PORT:=6379


docker_hub/help:
	@echo '$@'
	@echo 'make docker_hub/build     -> build the container locally'
	@echo 'make docker_hub/upload    -> upload the container to the docker hub (internal only)'
	@echo '                             (this will re-tag the container appropriately)'
	@echo 'make docker_hub/run       -> run the container from the docker hub'
	@echo 'make docker_hub/run-local -> run the container locally (for bootstrapping)'
	@echo 'make docker_hub/logs      -> tail the logs of a running docker hub server'
	@echo 'make docker_hub/stop      -> stop the docker hub server'
	@exit 0

include Makefile.d/*.mk
