#!/bin/bash

CONFIG_SERVER_URL="http://config-service:8888"
APPLICATION_NAME="gateway"
PROFILE="default"

CONFIG_URL="${CONFIG_SERVER_URL}/${APPLICATION_NAME}/${PROFILE}"
PORT=$(curl -s "${CONFIG_URL}" | jq -r '.propertySources[0] | select(.name | endswith(".yml")).source["server.port"]')

if [ -z "$PORT" ] || [ "$PORT" == "null" ]; then
  echo "Error: Could not fetch port from config server"
  exit 1
fi

export GATEWAY_PORT=$PORT
export PROFILE=$PROFILE

echo "GATEWAY_PORT=$GATEWAY_PORT"
echo "PROFILE=$PROFILE"

cat <<EOF > .env
GATEWAY_PORT=$GATEWAY_PORT
PROFILE=$PROFILE
EOF

docker compose --env-file .env up -d --build

rm .env