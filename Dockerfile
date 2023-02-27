# docker-hub/Dockerfile
# (c) 2023 Sam Caldwell <mail@samcaldwell.net>
#
# Docker registry builder
#
ARG VERSION="0.0.0"
ARG BASE_OPSYS=ubuntu:latest
#
# Base container build
#   - opsys
#   - nginx
#   - git
#
FROM ${BASE_OPSYS} AS base
ENV GO111MODULE=auto
ENV CGO_ENABLED=0
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends ca-certificates apt-transport-https nginx git
WORKDIR /usr/src/
#
# GoBuilder environment
#   - golang compiler
#   - build tools
#
FROM base AS gobuilder
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends golang make build-essential
#
# Copy Build Sources
#   - extend GoBuilder tooling with sources
#
FROM gobuilder AS buildsource
COPY upstream/distribution /usr/src/
#
# Build Binary Artifacts
#
FROM buildsource AS artifacts
RUN go build -v -trimpath \
             -o /usr/bin/registry cmd/registry/main.go

RUN go build -v -trimpath \
             -o /usr/bin/digest cmd/digest/main.go

RUN go build -v -trimpath \
             -o /usr/bin/registry-api-descriptor-template cmd/registry-api-descriptor-template/main.go

# The final runtime container
#
FROM base AS registry

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends cron

RUN echo '0 0 * * * /usr/bin/registry garbage-collect /etc/docker/registry/config.yml -m' > /etc/cron.daily/registry-garbage-collect
RUN mkdir -p /var/lib/registry/

COPY src/entrypoint.sh /usr/bin/
COPY src/config.yml /etc/docker/registry/config-prod.yml
COPY src/config-dev.yml /etc/docker/registry/config-dev.yml
COPY --from=artifacts /usr/bin/registry /usr/bin/
COPY --from=artifacts /usr/bin/digest /usr/bin/
COPY --from=artifacts /usr/bin/registry-api-descriptor-template /usr/bin/

VOLUME [ "/var/lib/registry" ]
VOLUME [ "/docker/registry/v2/repositories" ]

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
CMD [ "/usr/bin/entrypoint.sh" ]
