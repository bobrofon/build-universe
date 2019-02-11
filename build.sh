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
	'aarch64')
		TARGET='aarch64-unknown-linux-gnueabi'
		OS_COMPILER='linux-aarch64'
		;;
	'i686')
		TARGET='i686-unknown-linux-gnu'
		OS_COMPILER='linux-generic32'
		;;
	'x86_64')
		TARGET='x86_64-unknown-linux-gnu'
		OS_COMPILER='linux-generic64'
		;;
	*)
		echo 'Unexpected arch'
		;;
esac

CONTAINER_NAME="${TARGET}_universe"

docker build --build-arg TARGET="${TARGET}" --build-arg OS_COMPILER="${OS_COMPILER}" -t "${CONTAINER_NAME}" . ${@}
