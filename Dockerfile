FROM debian:stable

####################################################################################################

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		binfmt-support \
		qemu-user-static \
		make \
		file \
		perl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*_dists_*


RUN echo "dpkg-reconfigure qemu-user-static > /dev/null 2>&1" >> /etc/bash.bashrc

####################################################################################################

VOLUME /src
WORKDIR /src

####################################################################################################

ENV TOOLCHAIN_BASE_DIR /opt
ENV TOOLCHAIN_VERSION 1
ENV TARGET arm-unknown-linux-gnueabi
ENV HOST ${TARGET}
ENV TOOLCHAIN_IMAGE ${TARGET}_v${TOOLCHAIN_VERSION}.squash
ENV TOOLCHAIN_PATH ${TOOLCHAIN_BASE_DIR}/x-tools
ENV LD_LIBRARY_PATH ${TOOLCHAIN_BASE_DIR}/x-tools/${TARGET}/sysroot/lib

####################################################################################################

ADD x-tools/${TOOLCHAIN_IMAGE} ${TOOLCHAIN_BASE_DIR}/
RUN mkdir -p ${TOOLCHAIN_PATH}
ADD files/init.sh /init.sh
ADD files/gcc-static /bin/gcc-static

ENTRYPOINT ["/init.sh"]
