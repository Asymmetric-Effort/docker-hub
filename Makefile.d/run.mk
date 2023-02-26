docker_hub/initialize:
	@echo "$@ starting"
	mkdir -p $(DOCKER_HUB_VOLUME) || true
	@echo "$@ completed"

.$PHONY: docker_hub/run
REMOTE_IMAGE:=$(DOCKER_HUB)/$(DOCKER_HUB_DOCKER_IMAGE_NAME)
docker_hub/run: docker_hub/initialize
	@echo "$@ starting."
	@echo "...kill any running container"
	@docker kill $(DOCKER_HUB_DOCKER_CONTAINER_NAME) &> /dev/null || true
	@echo "...launching container"
	@docker run -d \
			   --rm \
			   --name $(DOCKER_HUB_DOCKER_CONTAINER_NAME) \
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_SSH_PORT):22 \
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_HTTP_PORT):80 \
			   --volume $(DOCKER_HUB_VOLUME):/git/ $(REMOTE_IMAGE) .
	@docker ps
	@echo "$@ completed."

.$PHONY: docker_hub/run/local
LOCAL_IMAGE:=$(DOCKER_HUB_DOCKER_IMAGE_NAME)
docker_hub/run/local: docker_hub/initialize
	@echo "$@ starting."
	@echo "...kill any running container"
	@docker kill $(DOCKER_HUB_DOCKER_CONTAINER_NAME) &> /dev/null || true
	@echo "...launching container"
	@docker run -d \
			   --rm \
			   --name $(DOCKER_HUB_DOCKER_CONTAINER_NAME) \
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_SSH_PORT):22 \
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_HTTP_PORT):80 \
			   --volume $(DOCKER_HUB_VOLUME):/git/ $(LOCAL_IMAGE) .
	@docker ps
	@echo "$@ completed."
