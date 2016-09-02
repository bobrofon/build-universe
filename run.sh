#! /bin/sh

CONTAINER_NAME="arm_universe"
docker run -v ${PWD}:/src --rm --privileged -it ${CONTAINER_NAME} $(id -u) $(id -g) "${@}"
