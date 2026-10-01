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
migration_marker=/data/.migrated_homeassistant_config
if [[ ! -f "${migration_marker}" ]]; then
  for legacy_file in \
    "/homeassistant${config_dir#/config}/vpn_server.config" \
    /homeassistant/softether/vpn_server.config; do
    if [[ "${config_dir}" == /config* && -s "${legacy_file}" ]]; then
      if [[ -s "${config_file}" ]]; then
        bashio::log.info "Backing up existing configuration to ${config_file}.pre-migration"
        cp -f "${config_file}" "${config_file}.pre-migration"
      fi
      bashio::log.info "Migrating configuration from ${legacy_file}"
      cp -f "${legacy_file}" "${config_file}"
      break
    fi
  done
  touch "${migration_marker}"
fi

if [[ ! -f "${config_file}" ]]; then
  touch "${config_file}"
fi

ln -sf "${config_file}" /vpnserver/vpn_server.config
