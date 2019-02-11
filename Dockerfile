FROM debian:sid

####################################################################################################

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		binfmt-support \
		qemu-user-static \
		make \
		ninja-build \
		cmake \
		autoconf \
		automake \
		libtool \
		libltdl-dev \
		file \
		perl \
		pkg-config \
		gettext \
		meson \
		python && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*_dists_*

####################################################################################################

VOLUME /src
WORKDIR /src

####################################################################################################

ENV TOOLCHAIN_BASE_DIR /opt
ARG TARGET=arm-unknown-linux-gnueabi
ENV TARGET ${TARGET}
ENV HOST ${TARGET}
ENV TOOLCHAIN_IMAGE ${TARGET}.sqsh
ENV TOOLCHAIN_PATH ${TOOLCHAIN_BASE_DIR}/x-tools
ENV CROSS_SYSROOT ${TOOLCHAIN_PATH}/${TARGET}/sysroot
ENV LD_LIBRARY_PATH ${CROSS_SYSROOT}/lib
ARG OS_COMPILER=linux-armv4
ENV OS_COMPILER ${OS_COMPILER}

####################################################################################################

ADD x-tools/${TOOLCHAIN_IMAGE} ${TOOLCHAIN_BASE_DIR}/
RUN mkdir -p ${TOOLCHAIN_PATH}
ADD files/init.sh /init.sh
ADD files/gcc-static /bin/gcc-static

####################################################################################################

ENV QEMU_BIN_DIR=/usr/bin
ADD qemu-user-static/register/register.sh /register
ADD qemu-user-static/register/qemu-binfmt-conf.sh /qemu-binfmt-conf.sh

ENTRYPOINT ["/init.sh"]
