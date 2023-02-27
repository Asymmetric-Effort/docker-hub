# docker-hub/Makefile.d/build.mk
# (c) 2023 Sam Caldwell <mail@samcaldwell.net>
#
# Docker registry builder
#	- Note we build in stages for easier debugging.
#
docker_hub/build:
	@echo "$@ starting."
	@docker build --compress \
				  --target registry \
				  --tag $(DOCKER_HUB_DOCKER_IMAGE_NAME) .
	@echo "$@ completed."


docker_hub/build/artifacts: docker_hub/build/buildsource
	@echo "$@ starting."
	@docker build --compress \
				  --target artifacts \
				  --tag $(DOCKER_HUB_DOCKER_IMAGE_NAME) .
	@echo "$@ completed."


docker_hub/build/buildsource: docker_hub/build/gobuilder
	@echo "$@ starting."
	@docker build --compress \
				  --target buildsource \
				  --tag $(DOCKER_HUB_DOCKER_IMAGE_NAME) .
	@echo "$@ completed."


docker_hub/build/gobuilder: docker_hub/build/base
	@echo "$@ starting."
	@docker build --compress \
				  --target gobuilder \
				  --tag $(DOCKER_HUB_DOCKER_IMAGE_NAME) .
	@echo "$@ completed."


docker_hub/build/base:
	@echo "$@ starting."
	@docker build --target base \
				  --build-arg VERSION=DOCKER_HUB_VERSION \
				  --build-arg BASE_OPSYS=ubuntu:latest \
				  --tag $(DOCKER_HUB_DOCKER_IMAGE_NAME) .
	@echo "$@ completed."


docker_hub/build/upstream:
	@echo "$@ starting."
	@( \
		set -e; \
		cd upstream/distribution || exit 1; \
		make clean || exit 2; \
		make lint || exit 3; \
		make vendor || exit 4; \
		make binaries || exit 5; \
		make build || exit 6; \
		echo "$@ done"; \
	)
