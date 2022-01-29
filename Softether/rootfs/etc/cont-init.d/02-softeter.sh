#!/usr/bin/with-contenv bashio

declare config_dir
config_dir=$(bashio::config 'config_dir')

if [[ ! -d $config_dir ]]
then
  mkdir $config_dir
fi

# if an configuration exists from an older version move it to the new location.
if [[ -d "/data/vpnserver" ]]
then
  cp -f /data/vpnserver/vpn_server.config $config_dir/vpn_server.config
  rm -r /data/vpnserver/
fi

if [[ ! -f "$config_dir/vpn_server.config" ]]
then
  touch $config_dir/vpn_server.config
fi

ln -s $config_dir/vpn_server.config /vpnserver/vpn_server.config
