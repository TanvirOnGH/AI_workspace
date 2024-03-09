#!/bin/sh

#set -eu

export VERSION=$(git describe --tags --first-parent --abbrev=7 --long --dirty --always | sed -e "s/^v//g" 2>/dev/null || echo "0.0.0")-$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
export GOFLAGS="'-ldflags=-w -s \"-X=github.com/ollama/ollama/version.Version=$VERSION\" \"-X=github.com/ollama/ollama/server.mode=release\"'"

# Remove the container first
docker stop ollama
docker rm ollama

# Build
docker build \
    --platform=linux/amd64 \
    --build-arg=VERSION \
    --build-arg=GOFLAGS \
    -f Dockerfile \
    -t ollama .

# Run
docker run -d --gpus=all -v ollama:/root/.ollama -v /home/user/workspace/ollama:/mnt/ollama -p 11434:11434 -e OLLAMA_ORIGINS="*" --name ollama --restart=always ollama
