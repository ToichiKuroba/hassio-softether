#!/usr/bin/with-contenv bashio

echo Hello world

#make -f /vpnserver/Makefile

if [[ ! -d "/data/vpnserver" ]]
then
    mv /vpnserver /data/vpnserver
fi

/data/vpnserver/vpnserver start

echo Hello world2

python3 -m http.server 9324