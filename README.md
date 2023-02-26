Asymmetric-Effort/Bootstrap/Docker-Hub
=======================================
(c) 2023 Sam Caldwell.  See LICENSE.txt

## Objective:
* To establish an internal docker hub as a container-based solution where users 
  can push/pull container images.
* ITERATION: Add a “proxy” feature to allow the docker hub to proxy a container
  image from a third-party docker hub.

## Building Container
To build...
1. Clone this repo
2. Navigate to the directory
3. Run `make docker_hub/build`

## To Run Local Container
To run this locally (e.g. bootstrapping an environment):
1. Build the container locally (see above).
2. Run `make docker_hub/run_local`

## To Upload the Image
To upload the container image:
1. Build the container (see above)
2. Run `make docker_hub/upload`

(Disclaimer: This currently is not implemented and
by design it will only upload to my local docker hub.)

## Stop Services
To stop the package server, run `make docker_hub/stop`

## Tailing logs of running services
To tail the logs, run `make docker_hub/logs`
