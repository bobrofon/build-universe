#! /bin/sh

mount ${TOOLCHAIN_BASE_DIR}/${TOOLCHAIN_IMAGE} ${TOOLCHAIN_PATH}
for FILE in ${TOOLCHAIN_PATH}/bin/${TARGET}-*
do
	LINK=/usr/local/bin/${FILE#${TOOLCHAIN_PATH}/bin/${TARGET}-}
	ln -s ${FILE} ${LINK}
done

cmd="${@:-bash}"
eval "$cmd"
