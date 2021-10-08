#!/bin/bash

xhost +local:docker
docker run --privileged -it \
        -d \
        --name foxy_unity \
        --hostname foxy_unity \
        -p 10000:10000 \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e "DISPLAY=$DISPLAY" \
        --device=/dev/dri:/dev/dri \
        foxy_unity bash