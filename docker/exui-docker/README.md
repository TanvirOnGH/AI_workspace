## This work is not official

I am providing this work as a helpful hand to people who are looking for a simple, easy to build docker image with GPU support, this is not official in any capacity, and any issues arising from this docker image should be posted here and not on their own repo or discord.

Known working with nvidia driver 535.129, may work on other versions

# EX-ui Docker

Docker images and configuration to run exui with GPU, currently being based off of latest commit whenever I feel like updating it, but the goal of this is to allow you to create it yourself with a clear concise Dockerfile that's understandable and transparent.

I am using noneabove1182/nvidia-runtime-docker:12.1.1-runtime-ubuntu22.04-535.129 for my final build stage to speed up subsequent builds, since it always starts with a long process that isn't ACTUALLY affected by previous build stage being changed, but docker build doesn't know that. It's simply taking the nvidia/cuda:12.1.1-runtime-ubuntu22.04 and updating packages and setting up proper driver versions such as 535.129

Here's a link to what that container is built from:
https://github.com/noneabove1182/nvidia-runtime-docker-for-llms

# Special tweaks

The included start.sh starts the conda environment and then starts the server with any given run commands.

In order to have data persist between sessions, I pass a data directory and then pass the runtime arg '--dir /data'

# Running the image with docker run

```sh
docker run --gpus all -p 7860:7860 -v /media/teamgroup/models:/models -v ./data:/data exui:latest --host 0.0.0.0:7860 --dir /data
```

# Running the image with docker compose

A docker-compose.yaml file has been provided, as well as a .env file that I use for setting my model dir and data dir.

Feel free to modify both to fit your needs.

# Pre-built image

Pre-built images provided at https://hub.docker.com/r/noneabove1182/exui
