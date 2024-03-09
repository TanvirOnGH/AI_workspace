#!/bin/sh

# $1 - Model Name
# $2 - Modelfile location
docker exec -it ollama ollama create "$1" -f /mnt/ollama-mnt/"$2"
