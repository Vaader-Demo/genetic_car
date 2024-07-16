#!/bin/bash

printf "Starting with camera devices\n"
test -e /dev/video0 && CAM0=--device=/dev/video0:/dev/video0
test -e /dev/video1 && CAM1=--device=/dev/video1:/dev/video1
test -e /dev/video2 && CAM2=--device=/dev/video2:/dev/video2
test -e /dev/video3 && CAM3=--device=/dev/video3:/dev/video3
echo $CAM0 $CAM1 $CAM2 $CAM3

IMAGE_NAME="genetic_car"

# Test if image exists
docker image inspect $IMAGE_NAME > /dev/null

if [ $? -ne 0 ]; then
    docker build . -t $IMAGE_NAME
fi
xhost +local:docker
docker run --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY $CAM0 $CAM1 $CAM2 $CAM3 --rm -it $IMAGE_NAME
