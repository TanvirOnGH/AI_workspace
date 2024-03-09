#!/bin/bash

# Remove the models directory and create a symbolic link

if [[ -d /models ]] ; then
    echo "Found models, linking the directory"
    rm -r /stable-diffusion-webui/models/Stable-diffusion
    ln -s /models /stable-diffusion-webui/models/Stable-diffusion
else
    echo "No models DIR"
fi

if [[ -d /images ]] ; then
    echo "Found images, linking the directory"
    rm -r /stable-diffusion-webui/logs/images
    mkdir /stable-diffusion-webui/logs
    ln -s /images /stable-diffusion-webui/logs/images
else
    echo "No images DIR"
fi

# Start the server
conda run --live-stream -n diffusion python3 webui.py "$@"
