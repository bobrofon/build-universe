#! /bin/sh

set -eu

TARGET=${1}
shift

CONTAINER_NAME="${TARGET}_universe"

if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 ; then
	ROOT="$(git rev-parse --show-toplevel)"
else
	ROOT="${PWD}"
fi

docker run -v ${ROOT}:/src --rm --privileged -it ${CONTAINER_NAME} $(id -u) $(id -g) ${ROOT} ${PWD} "${@}"
