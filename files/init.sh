#! /bin/sh

set -eu

UID=$1
shift
GID=$1
shift
ROOT=$1
shift
WORKING_DIRECTORY=$1
shift

USER=hostuser
GROUP=hostgroup

groupadd --gid ${GID} ${GROUP}
useradd --no-user-group --no-create-home --uid=${UID} --gid=${GID} ${USER}

export LD_LIBRARY_PATH="/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}"

mount ${TOOLCHAIN_BASE_DIR}/${TOOLCHAIN_IMAGE} ${TOOLCHAIN_PATH}
for FILE in ${TOOLCHAIN_PATH}/bin/${TARGET}-*
do
	LINK=/usr/local/bin/${FILE#${TOOLCHAIN_PATH}/bin/${TARGET}-}
	ln -s ${FILE} ${LINK}
done

ln -s ${LD_LIBRARY_PATH}/ld-linux.so.3 /lib/ld-linux.so.3

export PATH=${PATH}:${TOOLCHAIN_PATH}/bin

/register --reset > /dev/null 2>&1

mkdir -p ${ROOT}
mount --bind ${PWD} ${ROOT}
cd ${WORKING_DIRECTORY}

CMD="${@:-bash}"
su ${USER} -c "${CMD}"
