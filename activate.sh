#! /bin/bash

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

ARCH=${1:-'arm'}

case "${ARCH}" in
	'arm')
		TARGET='arm-unknown-linux-gnueabi'
		;;
	'aarch64')
		TARGET='aarch64-unknown-linux-gnueabi'
		;;
	'i686')
		TARGET='i686-unknown-linux-gnu'
		;;
	'x86_64')
		TARGET='x86_64-unknown-linux-gnu'
		;;
	*)
		echo "Unexpected arch"
		;;
esac

function run {
	CMD="${ABSOLUTE_PATH}/run.sh ${TARGET} ${@}"
	eval $CMD
}
