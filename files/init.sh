#! /bin/sh

mount ${TOOLCHAIN_BASE_DIR}/${TOOLCHAIN_IMAGE} ${TOOLCHAIN_PATH}
for FILE in ${TOOLCHAIN_PATH}/bin/${TARGET}-*
do
	LINK=/usr/local/bin/${FILE#${TOOLCHAIN_PATH}/bin/${TARGET}-}
	ln -s ${FILE} ${LINK}
done

ln -s ${LD_LIBRARY_PATH}/ld-linux.so.3 /lib/ld-linux.so.3

export PATH=${PATH}:${TOOLCHAIN_PATH}/bin

cmd="${@:-bash}"
eval "$cmd"
