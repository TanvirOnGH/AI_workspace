## My nvidia-runtime image

This is an image I've created for use in my other docker images. I base my final container image on nvidia-runtime so that it's smaller, but then I want to update it with a few things and change out the drivers, which makes the final portion of the build take a long time as everything before it has changed. So, in order to save my sanity (and possibly yours), I've created this image to act as a new unchanging baseline.

# Build locally

`sh
docker build -t noneabove1182/nvidia-runtime-docker:12.1.1-runtime-ubuntu22.04-535.129 .
`

Prebuilt images can be found here:

https://hub.docker.com/r/noneabove1182/nvidia-runtime-docker
