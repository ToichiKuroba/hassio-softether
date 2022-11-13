ARG BUILD_FROM
FROM $BUILD_FROM

RUN apt-get update \
    && apt-get install -y \
        gcc \
        wget \
        make \
    && wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.39-9772-beta/softether-vpnserver-v4.39-9772-beta-2022.04.26-linux-arm64-64bit.tar.gz\
    && tar xzvf softether-vpnserver-v4.39-9772-beta-2022.04.26-linux-arm64-64bit.tar.gz \
    && rm softether-vpnserver-v4.39-9772-beta-2022.04.26-linux-arm64-64bit.tar.gz \
    && cd /vpnserver \
    && make 

# Copy root filesystem
COPY rootfs /

RUN chmod 777 /etc/cont-init.d/02-softeter.sh

CMD [ "/vpnserver/vpnserver", "execsvc" ]
