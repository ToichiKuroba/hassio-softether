ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_ARCH

RUN apt-get update \
    && apt-get install -y \
        gcc \
        wget \
        make \
        iptables

RUN case "${BUILD_ARCH}" in \
        aarch64) SOFTETHER_ARCH="arm64-64bit" ;; \
        amd64)   SOFTETHER_ARCH="x86_64-64bit" ;; \
        armv7)   SOFTETHER_ARCH="arm32-v7l-32bit" ;; \
        armhf)   SOFTETHER_ARCH="arm32-v7l-32bit" ;; \
        i386)    SOFTETHER_ARCH="x86-32bit" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac \
    && wget "https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.44-9807-rtm/softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-${SOFTETHER_ARCH}.tar.gz" \
    && tar xzvf "softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-${SOFTETHER_ARCH}.tar.gz" \
    && rm "softether-vpnserver-v4.44-9807-rtm-2025.04.16-linux-${SOFTETHER_ARCH}.tar.gz" \
    && cd /vpnserver \
    && make

# Copy root filesystem
COPY rootfs /

RUN chmod 777 /etc/cont-init.d/02-softeter.sh

CMD [ "/vpnserver/vpnserver", "execsvc" ]
