docker_hub/stop:
	@echo "$@ running"
	docker kill $(DOCKER_HUB_DOCKER_CONTAINER_NAME)
	@echo "$@ done"