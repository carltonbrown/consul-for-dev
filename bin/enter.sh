#!/usr/bin/env bash
# Enter your Consul container for debugging
. ../.env
docker exec -it ${CONTAINER_NAME} /bin/sh

