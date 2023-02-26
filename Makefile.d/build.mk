docker_hub/build:
	@echo "$@ starting."
	docker build --compress --tag $(DOCKER_HUB_DOCKER_IMAGE_NAME) .
	@echo "$@ completed."

