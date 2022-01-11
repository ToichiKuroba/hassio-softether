ARG BUILD_FROM
FROM $BUILD_FROM

RUN apt-get update \
    && apt-get install -y \
        gcc \
        wget \
        make \
    && wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.38-9760-rtm/softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-arm_eabi-32bit.tar.gz \
    && tar xzvf softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-arm_eabi-32bit.tar.gz  \
	&& rm softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-arm_eabi-32bit.tar.gz \
    && cd /vpnserver \
    && make 

WORKDIR /data

# Copy root filesystem
COPY rootfs /

# RUN chmod a+x /etc/cont-init.d/vpnserver/02-softeter.sh

CMD [ "/data/vpnserver/vpnserver", "execsvc" ]
