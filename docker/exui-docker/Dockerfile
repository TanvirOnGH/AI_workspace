# cuda devel image for base, best build compatibility
FROM nvidia/cuda:12.1.1-devel-ubuntu22.04 as builder

# Using conda to transfer python env from builder to runtime later
COPY --from=continuumio/miniconda3:23.5.2-0 /opt/conda /opt/conda
ENV PATH=/opt/conda/bin:$PATH

# Update base image and install dependencies
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y git build-essential \
    ocl-icd-opencl-dev opencl-headers clinfo \
    && mkdir -p /etc/OpenCL/vendors && echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd

# Create new conda environment
RUN conda create -y -n exui python=3.11.5
SHELL ["conda", "run", "-n", "exui", "/bin/bash", "-c"]

ENV CUDA_DOCKER_ARCH=all

RUN pip3 install torch==2.1.0 torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

ARG version

RUN pip install exllamav2==$version

RUN pip3 install huggingface_hub transformers packaging flask

RUN git clone https://github.com/turboderp/exui \
    && pip3 install -r /exui/requirements.txt

RUN conda clean -afy

# Using fully set up runtime for smaller final image with proper drivers
FROM noneabove1182/nvidia-runtime-docker:12.1.1-runtime-ubuntu22.04

# Copy conda and cuda files over
COPY --from=builder /opt/conda /opt/conda
COPY --from=builder /usr/local/cuda-12.1/targets/x86_64-linux/include /usr/local/cuda-12.1/targets/x86_64-linux/include 

ENV PATH=/opt/conda/bin:$PATH

COPY --from=builder /exui /exui

WORKDIR /exui

ENV CUDA_DOCKER_ARCH=all

EXPOSE 7860

COPY start.sh /start.sh
RUN chmod +x /start.sh

# Define the entrypoint
ENTRYPOINT ["/start.sh"]
