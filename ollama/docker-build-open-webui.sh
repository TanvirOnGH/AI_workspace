#!/bin/sh
# set -eu
# <https://github.com/open-webui/open-webui>

git pull

# Remove the container first
docker stop ollama-webui
docker rm ollama-webui

# Build
docker build -t open-webui .

# Run
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always open-webui
