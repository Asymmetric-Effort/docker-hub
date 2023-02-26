docker_hub/logs:
	@echo "$@ starting..."
	docker logs -f $(DOCKER_HUB_DOCKER_CONTAINER_NAME)