#!/bin/bash

xhost +local:docker
sudo xhost +
docker run --privileged -it \
        -d \
        --name foxy_unity \
        --hostname foxy_unity \
        --network host \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v `pwd`/Projects/dev_ws_src:/home/user/dev_ws/src \
        -e "DISPLAY=$DISPLAY" \
        --device=/dev/dri:/dev/dri \
        foxy_unity bash
