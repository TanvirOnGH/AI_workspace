# Build Docker image

- build 0net image: `docker build -t 0net-conservancy:latest . -f Dockerfile`
- or build 0net image with integrated tor: `docker build -t 0net-conservancy:latest . -f Dockerfile.integrated_tor`
- and run it: `docker run --rm -it -v </path/to/0n/data/directory>:/app/data -p 43110:43110 -p 26552:26552 0net-conservancy:latest`
- /path/to/0n/data/directory - directory, where all data will be saved, including your secret certificates. If you run it with production mode, do not remove this folder!
- or you can run it with docker-compose: `docker compose up -d 0net-conservancy` up two containers - 0net and tor separately.
- or: `docker compose up -d 0net-tor` for run 0net and tor in one container.
(please check if these instructions are still accurate)
