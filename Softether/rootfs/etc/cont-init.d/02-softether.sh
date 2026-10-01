#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

config_dir=$(bashio::config 'config_dir')
config_file="${config_dir}/vpn_server.config"

mkdir -p "${config_dir}"

# Migrate configuration from versions < 0.3.0
if [[ -d /data/vpnserver ]]; then
  if [[ -f /data/vpnserver/vpn_server.config ]]; then
    bashio::log.info "Migrating configuration from /data/vpnserver"
    cp -f /data/vpnserver/vpn_server.config "${config_file}"
  fi
  rm -rf /data/vpnserver
fi

# Migrate configuration from versions < 0.5.0, where /config was the Home Assistant config folder
if [[ ! -f "${config_file}" && "${config_dir}" == /config* ]]; then
  legacy_file="/homeassistant${config_dir#/config}/vpn_server.config"
  if [[ -f "${legacy_file}" ]]; then
    bashio::log.info "Migrating configuration from ${legacy_file}"
    cp "${legacy_file}" "${config_file}"
  fi
fi

if [[ ! -f "${config_file}" ]]; then
  touch "${config_file}"
fi

ln -sf "${config_file}" /vpnserver/vpn_server.config
