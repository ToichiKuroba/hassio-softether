# Home Assistant Add-on: Google Assistant SDK

## Installation

Todo

## Configuration

Todo
## How to use

If you want to use a dedicated Network Interface Card (NIC) it might be necessary to change the default NIC.
For that, use the SSH & Web Terminal Add-on.

The following command shows the Connections. The first one is the default connection.
```bash
 nmcli connection
```
With this command you can lower the priority of a connection so an outer one will be the default connection after reboot.
```bash
nmcli connection modify Supervisor\ enp1s0u1u1 ipv4.route-metric 2000
```

### Troubleshooting

TODO

## Support

TODO