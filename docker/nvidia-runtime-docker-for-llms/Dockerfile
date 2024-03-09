FROM nvidia/cuda:12.1.1-runtime-ubuntu22.04

# Setting frontend to noninteractive to avoid getting locked on keyboard input
ENV DEBIAN_FRONTEND=noninteractive
ENV CUDA_DOCKER_ARCH=all

# Installing all the packages we need and updating cuda-keyring
RUN apt-get -y update && apt-get -y install wget && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb \
    && dpkg -i cuda-keyring_1.0-1_all.deb && apt-get update && apt-get upgrade -y \
    && apt-get -y install python3 build-essential

RUN apt-get install -y --allow-change-held-packages libcublas-12-1 \
    && apt-get -y install cuda-12.1 && apt-get -y install cuda-12.1 

RUN apt-get update && apt-get remove --purge -y nvidia-*  \
    && apt-get install -y aptitude

ENV SUDO_FORCE_REMOVE=yes

RUN aptitude -f -y install nvidia-driver-535/jammy-updates \
    && apt-get autoremove \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*