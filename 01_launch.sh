#!/bin/bash

xhost +local:docker
sudo xhost +
export DISPLAY=:0.0
docker run --privileged -it \
        -d \
        --name foxy_unity \
        --hostname foxy_unity \
        --network host \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e "DISPLAY=$DISPLAY" \
        --device=/dev/dri:/dev/dri \
        foxy_unity bash
