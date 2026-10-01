FROM ghcr.io/hassio-addons/debian-base:9.5.0

ARG BUILD_ARCH
ARG SOFTETHER_VERSION=v4.44-9807-rtm
ARG SOFTETHER_DATE=2025.04.16

# gcc/make are only needed to link the prebuilt vpnserver objects and are removed afterwards
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        libc6-dev \
        make \
        iptables \
    && case "${BUILD_ARCH}" in \
        aarch64) SOFTETHER_ARCH="arm64-64bit" ;; \
        amd64)   SOFTETHER_ARCH="x64-64bit" ;; \
        *) echo "Unsupported architecture: ${BUILD_ARCH}" && exit 1 ;; \
    esac \
    && tarball="softether-vpnserver-${SOFTETHER_VERSION}-${SOFTETHER_DATE}-linux-${SOFTETHER_ARCH}.tar.gz" \
    && curl -fsSL -o "/tmp/${tarball}" \
        "https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/${SOFTETHER_VERSION}/${tarball}" \
    && tar xzf "/tmp/${tarball}" -C / \
    && rm "/tmp/${tarball}" \
    && make -C /vpnserver \
    && apt-get purge -y --auto-remove gcc libc6-dev make \
    && rm -rf /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /

RUN chmod 755 /etc/cont-init.d/02-softether.sh

CMD [ "/vpnserver/vpnserver", "execsvc" ]
