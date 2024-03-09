#!/bin/sh

git pull

# Remove the container first
docker stop ollama-webui
docker rm ollama-webui

docker build -t ollama-webui .
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway --name ollama-webui --restart always ollama-webui:latest
