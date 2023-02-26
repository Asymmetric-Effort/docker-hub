DOCKER_HUB:=docker.internal.asymmetric-effort.com
DOCKER_HUB_DOCKER_IMAGE_NAME:=asymmetric-effort/git-server:local
DOCKER_HUB_DOCKER_CONTAINER_NAME:=git-server
DOCKER_HUB_IP_ADDRESS:=10.37.129.2
DOCKER_HUB_SSH_PORT:=22
DOCKER_HUB_HTTP_PORT:=8888
DOCKER_HUB_VOLUME:=$(HOME)/docker_hub

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
