#!/usr/bin/env bash

cat > lookup.env <<"EOF"
{{ lookup_env_content }}
EOF

# doesn't work without timeout
sleep 5

docker run -d \
    --restart=always \
    --name bureau-mock \
    -p 1080:1080 \
    jamesdbloom/mockserver

docker run -d \
    --restart=always \
    --name lookup-service-database \
    -p 5432:5432 \
    -e POSTGRES_DB='lookup' -e POSTGRES_USER='lookup' \
    "postgres:{{ postgres_version }}"

docker run -d \
    --restart=always \
    --name lookup-service \
    -p 8080:8080 -p 8081:8081 \
    --env-file lookup.env \
    --link bureau-mock --link lookup-service-database \
    "hub.int.klarna.net/idun/lookup-service:{{ lookup_service_version }}"