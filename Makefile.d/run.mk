docker_hub/initialize:
	@echo "$@ starting"
	mkdir -p $(DOCKER_HUB_VOLUME) || true
	@echo "$@ completed"

.$PHONY: docker_hub/run
REMOTE_IMAGE:=$(DOCKER_HUB)/$(DOCKER_HUB_DOCKER_IMAGE_NAME)
docker_hub/run: docker_hub/stop docker_hub/initialize
	@echo "$@ starting."
	@echo "...launching container"
	@docker run -d \
			   --rm \
			   --name $(DOCKER_HUB_DOCKER_CONTAINER_NAME) \
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_PORT):5000 \
			   --publish $(DOCKER_HUB_IP_ADDRESS):8126:8126 \
			   -e REGISTRY_HTTP_SECRET=$(DOCKER_HUB_REGISTRY_HTTP_SECRET) \
			   -e REGISTRY_HTTP_ADDR=0.0.0.0:8126 \
			   -e REGISTRY_STORAGE_CACHE_BLOBDESCRIPTOR=redis \
			   -e REGISTRY_REDIS_ADDR=$(DOCKER_REDIS_IP_ADDRESS):$(DOCKER_REDIS_PORT) \
			   --volume $(DOCKER_HUB_VOLUME):/var/lib/registry/ $(REMOTE_IMAGE)
	@docker ps
	@echo "$@ completed."

.$PHONY: docker_hub/run/local
LOCAL_IMAGE:=$(DOCKER_HUB_DOCKER_IMAGE_NAME)
docker_hub/run/local: docker_hub/stop docker_hub/initialize
	@echo "$@ starting."
	@echo "...launching container"
	@docker run -d \
			   --rm \
			   --name $(DOCKER_HUB_DOCKER_CONTAINER_NAME) \
			   --publish $(DOCKER_HUB_IP_ADDRESS):$(DOCKER_HUB_PORT):5000 \
			   --publish $(DOCKER_HUB_IP_ADDRESS):8126:8126 \
			   -e REGISTRY_HTTP_SECRET=$(DOCKER_HUB_REGISTRY_HTTP_SECRET) \
			   -e REGISTRY_HTTP_ADDR=0.0.0.0:8126 \
			   -e REGISTRY_STORAGE_CACHE_BLOBDESCRIPTOR=redis \
			   -e REGISTRY_REDIS_ADDR=$(DOCKER_REDIS_IP_ADDRESS):$(DOCKER_REDIS_PORT) \
			   --volume $(DOCKER_HUB_VOLUME):/var/lib/registry/ $(LOCAL_IMAGE)
	@docker ps
	@echo "$@ completed."

.$PHONY: docker_hub/redis/run/local
docker_hub/redis/run/local:
	docker run -d \
	 		   --rm \
	 		   --name $(DOCKER_REDIS_CONTAINER_NAME) -d \
	 		   --publish $(DOCKER_REDIS_IP_ADDRESS):$(DOCKER_REDIS_PORT):$(DOCKER_REDIS_PORT) $(DOCKER_REDIS_IMAGE)
