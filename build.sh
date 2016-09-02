#! /bin/sh

set -eu

ARCH='arm'

if [ "${#}" -ge 1 ]
then
	ARCH=${1}
	shift
fi

case "${ARCH}" in
	'arm')
		TARGET='arm-unknown-linux-gnueabi'
		OS_COMPILER='linux-armv4'
		;;
	'i686')
		TARGET='i686-unknown-linux-gnu'
		OS_COMPILER='linux-generic32'
		;;
	*)
		echo 'Unexpected arch'
		;;
esac

CONTAINER_NAME="${TARGET}_universe"

docker build --build-arg TARGET="${TARGET}" --build-arg OS_COMPILER="${OS_COMPILER}" -t "${CONTAINER_NAME}" . ${@}
