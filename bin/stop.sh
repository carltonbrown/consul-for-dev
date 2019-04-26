#!/usr/bin/env bash
# Stop and remove your local consul server
. ../env
docker rm -f ${CONTAINER_NAME}
