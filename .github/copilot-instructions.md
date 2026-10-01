# Projektkontext: hassio-softether

Home Assistant Add-on-Repository, das einen **SoftEther VPN Server** (v4.44-9807-rtm, Stable) als Add-on bereitstellt.
Maintainer: Frederick Weimann, Leo Birkner. Upstream-Repo: https://github.com/ToichiKuroba/hassio-softether

## Struktur

- `repository.json` – Metadaten des Add-on-Repositorys (Name, URL, Maintainer).
- `README.md` – Repo-README mit "Add repository"-Badge und Arch-Shields.
- `Softether/` – das eigentliche Add-on (Slug `soft_ether_vpn_server`):
  - `config.yaml` – Add-on-Manifest (Version, Arch, Optionen, Schema, Rechte).
  - `build.yaml` – Base-Images pro Arch (`ghcr.io/hassio-addons/debian-base:9.5.0`). Ab debian-base 9.0.0 gibt es nur noch aarch64/amd64.
  - `Dockerfile` – ein einziger `RUN`: installiert gcc/libc6-dev/make/iptables, lädt per `curl` das SoftEther-Tarball passend zu `BUILD_ARCH` (Version/Datum über `ARG SOFTETHER_VERSION`/`SOFTETHER_DATE`), entpackt nach `/vpnserver`, linkt mit `make` und entfernt die Build-Tools wieder. `CMD ["/vpnserver/vpnserver", "execsvc"]`.
  - `rootfs/etc/cont-init.d/02-softether.sh` – s6 cont-init-Skript (bashio): legt `config_dir` an, migriert alte Configs (aus `/data/vpnserver` bzw. `/homeassistant/...` von Versionen < 0.5.0), legt leere `vpn_server.config` an und symlinkt sie (`ln -sf`) nach `/vpnserver/vpn_server.config`.
  - `DOCS.md` – Nutzerdoku (Anzeige im HA-UI), `README.md` – Kurzbeschreibung, `CHANGELOG.md`, `icon.png`, `logo.png`.

## Laufzeitverhalten

- Base-Image bringt s6-overlay v3 mit (`init: false` in `config.yaml`, damit s6 PID 1 ist). cont-init.d-Skripte laufen vor dem `CMD`.
- `host_network: true`, `privileged: [NET_ADMIN]`, `advanced: true`, `stage: experimental`.
- Option `config_dir` (Default `/config`), Schema `match(^/(config|share)(/.*)?$)`.
- Mappings: `addon_config` (rw, im Container `/config`, auf dem Host `/addon_configs/<repo-id>_soft_ether_vpn_server`), `homeassistant_config` (ro, `/homeassistant`, nur für Migration aus < 0.5.0 – kann in einer späteren Version entfernt werden), `share` (rw).
- Konfiguration des VPN-Servers erfolgt ausschließlich über den externen **SoftEther VPN Server Manager** (Port 5555). Keine Add-on-Optionen für Hubs/User etc.
- Nur `vpn_server.config` wird persistiert. Logs (`server_log`, `security_log`, `packet_log`), `backup.vpn_server.config` usw. landen in `/vpnserver` im Container und gehen bei Neuerstellung verloren.

## Architektur-Mapping (Dockerfile)

Home Assistant und debian-base unterstützen kein 32-bit mehr (seit 0.5.0 entfernt).

| HA `BUILD_ARCH` | SoftEther-Tarball |
|---|---|
| aarch64 | `linux-arm64-64bit` |
| amd64 | `linux-x64-64bit` |

Tarball-Schema: `softether-vpnserver-<tag>-<build-datum>-linux-<arch>.tar.gz` (Assets vorher im Release prüfen, Namen weichen von den HA-Arch-Namen ab).

## Release-Workflow (Konvention)

Bei Änderungen am Add-on:
1. `version` in `Softether/config.yaml` erhöhen (SemVer, aktuell `0.5.x`).
2. Eintrag in `Softether/CHANGELOG.md` ergänzen (Abschnitte `Added` / `Changed` / `Removed` / `Fixed`, neueste Version oben).
3. Bei SoftEther-Update: `ARG SOFTETHER_VERSION` und `ARG SOFTETHER_DATE` im `Dockerfile` anpassen. Stand 2026-10: v4.44-9807-rtm ist die neueste Stable-Version.
4. Bei Arch-Änderungen: `config.yaml` `arch`, `build.yaml`, `Dockerfile`-case und Shields in beiden READMEs synchron halten.

Es gibt kein CI und keine Tests. Lokaler Testbuild (Docker Desktop muss laufen):
`docker build --build-arg BUILD_FROM=ghcr.io/hassio-addons/debian-base:9.5.0 --build-arg BUILD_ARCH=amd64 -t softether-test Softether`

## Offene Punkte

- Nur `vpn_server.config` wird persistiert; Logs (`server_log`, `security_log`, `packet_log`) und `backup.vpn_server.config` gehen bei Neuerstellung des Containers verloren.
- `homeassistant_config`-Mapping nur für Migration nötig; nach einigen Releases entfernen.

## Sprache

Der Nutzer kommuniziert auf Deutsch; Doku-Dateien im Add-on (DOCS/README/CHANGELOG) sind auf Englisch.
