#!/bin/bash -e
# (c) 2023 Sam Caldwell <mail@samcaldwell.net>
#
# Docker registry entrypoint
#

#
# our symlink will be used to ensure everything that
# consumes the configuration will get the same config
#   - registry serve (this file)
#   - registry garbage-collect (daily cron)
#
if [[ "${ENVIRONMENT}" == "development" ]]; then
  ln -sf /etc/docker/registry/config-dev.yml /etc/docker/registry/config.yml
else
  ln -sf /etc/docker/registry/config-prod.yml /etc/docker/registry/config.yml
fi

if [[ "${REGISTRY_HTTP_SECRET}_" == "_" ]]; then
  echo "you must set REGISTRY_HTTP_SECRET before running"
  exit 1
fi

service cron start

registry serve /etc/docker/registry/config.yml
