ARG BUILD_FROM
FROM $BUILD_FROM

RUN apt-get update \
    && apt-get install -y \
        python3 \ 
        gcc \
        wget \
        make \
#		net-tools \
#		iproute2 \
    && wget https://github.com/SoftEtherVPN/SoftEtherVPN_Stable/releases/download/v4.38-9760-rtm/softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-arm_eabi-32bit.tar.gz \
    && tar xzvf softether-vpnserver-v4.38-9760-rtm-2021.08.17-linux-arm_eabi-32bit.tar.gz  \
    && ls \
    && cd /vpnserver \
    && ls \
    && make 

WORKDIR /data

# Copy data
COPY run.sh /
RUN chmod a+x /run.sh
CMD [ "/run.sh" ]