#!/usr/bin/env bash
# Follow the logs of your consul container
. ../.env
docker logs -f ${CONTAINER_NAME}
