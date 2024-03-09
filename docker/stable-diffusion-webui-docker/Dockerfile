# cuda devel image for base, best build compatibility
FROM nvidia/cuda:11.8.0-devel-ubuntu22.04 as builder

# Using conda to transfer python env from builder to runtime later
COPY --from=continuumio/miniconda3:23.5.2-0 /opt/conda /opt/conda
ENV PATH=/opt/conda/bin:$PATH

# Update base image
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    ocl-icd-opencl-dev opencl-headers clinfo \
    libglib2.0-0 libsm6 libxrender1 libxext6 \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# Create new conda environment
RUN conda create -y -n diffusion python=3.10.9
SHELL ["conda", "run", "-n", "diffusion", "/bin/bash", "-c"]

ENV CUDA_DOCKER_ARCH=all

# Installing torch and ninja
RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Pulling latest text-generation-webui branch
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git --branch v1.5.1  \
    && cd stable-diffusion-webui \
    && pip3 install -r requirements.txt

RUN cd stable-diffusion-webui && python3 launch.py --skip-torch-cuda-test --exit

RUN pip3 install xformers

RUN conda clean -afy

# Using runtime for smaller final image
FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

# Copy conda and cuda files over
COPY --from=builder /opt/conda /opt/conda
COPY --from=builder /usr/local/cuda-11.8/targets/x86_64-linux/include /usr/local/cuda-11.8/targets/x86_64-linux/include 

ENV PATH=/opt/conda/bin:$PATH

# Copy git repo from builder
COPY --from=builder /stable-diffusion-webui /stable-diffusion-webui

# Setting frontend to noninteractive to avoid getting locked on keyboard input
ENV DEBIAN_FRONTEND=noninteractive
ENV CUDA_DOCKER_ARCH=all

# Installing all the packages we need and updating cuda-keyring
# Some of this may be redundant, if you see something say something
RUN apt-get -y update && apt-get -y install git wget && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb \
    && dpkg -i cuda-keyring_1.0-1_all.deb && apt-get update && apt-get upgrade -y \
    && apt-get -y install python3 build-essential \
    && apt-get -y install cuda-11.8 && apt-get -y install cuda-11.8 \
    && systemctl enable nvidia-persistenced \
    && cp /lib/udev/rules.d/40-vm-hotadd.rules /etc/udev/rules.d \
    && sed -i '/SUBSYSTEM=="memory", ACTION=="add"/d' /etc/udev/rules.d/40-vm-hotadd.rules

RUN apt-get update && apt-get remove --purge -y nvidia-* \
    && apt-get install -y --allow-downgrades nvidia-driver-535/jammy-updates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the working directory
WORKDIR /stable-diffusion-webui

EXPOSE 7860
EXPOSE 7861

RUN conda init bash

RUN echo "source activate diffusion" >> ~/.bashrc

# start.sh sets up the various available directories like models and characters
# installs requirements for any user-included extensions
# Also provides a conda env activated entrypoint
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Define the entrypoint
ENTRYPOINT ["/start.sh"]