#!/usr/bin/env bash
. ../.env

bash ../build.sh

CONTAINER_CONFIG_DIR=/etc/consul.d
CONTAINER_DATA_DIR=/var/lib/consul


docker run -d --init --name $CONTAINER_NAME --rm \
  -p 8300:8300/tcp -p 8301:8301 -p 8302:8302 -p 8500:8500/tcp -p 8600:8600 \
  -v ~/src/consul/data:${CONTAINER_DATA_DIR} \
  -v ~/src/consul/config:${CONTAINER_CONFIG_DIR} \
  --entrypoint /bin/consul \
  $IMAGE_NAME agent -ui -server --bootstrap-expect=1 -client 0.0.0.0  -data-dir=${CONTAINER_DATA_DIR} -config-dir=${CONTAINER_CONFIG_DIR} && \

docker logs -f $CONTAINER_NAME
