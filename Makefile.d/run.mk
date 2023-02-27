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
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_PORT):5000 \
			   -e REGISTRY_HTTP_SECRET=$(DOCKER_HUB_REGISTRY_HTTP_SECRET) \
			   --volume $(DOCKER_HUB_VOLUME):/var/lib/registry/ $(REMOTE_IMAGE) .
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
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_PORT):5000 \
			   -e REGISTRY_HTTP_SECRET=$(DOCKER_HUB_REGISTRY_HTTP_SECRET) \
			   --volume $(DOCKER_HUB_VOLUME):/var/lib/registry/ $(LOCAL_IMAGE) .
	@docker ps
	@echo "$@ completed."
