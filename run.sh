#! /bin/sh

set -eu

TARGET=${1}
shift

CONTAINER_NAME="${TARGET}_universe"

docker run -v ${PWD}:/src --rm --privileged -it ${CONTAINER_NAME} $(id -u) $(id -g) "${@}"
