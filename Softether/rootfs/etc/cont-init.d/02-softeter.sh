#!/usr/bin/with-contenv bashio

if [[ ! -d "/data/vpnserver" ]]
then
    mv /vpnserver /data/vpnserver
fi