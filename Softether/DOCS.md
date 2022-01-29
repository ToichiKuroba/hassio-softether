# Home Assistant Add-on: SoftEther VPN Server

SoftEther VPN ("SoftEther" means "Software Ethernet") is one of the world's most powerful and easy-to-use multi-protocol VPN software. It runs on Windows, Linux, Mac, FreeBSD and Solaris

## Installation

1. Install the repository in your Add-on Store. [![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FToichiKuroba%2Fhassio-softether)
1. Find the Add-on in your Add-on Store and install it. (The default Configuration will work just fine)
1. Download the [SoftEther VPN Server Manager](https://www.softether-download.com/en.aspx?product=softether) for your Operating system.
1. Connect to your SoftEther VPN Server via the Server Manager. The used Port is 5555. 


## Configuration

To configure the SoftEther VPN Server please use the [SoftEther VPN Server Manager](https://www.softether-download.com/en.aspx?product=softether).

The Add-on configuration in Home Assistent is quiet simple:

```yaml
config_dir: /config/softether
```

### Option: `config_dir`

The directory to store the the config.

By default this Value is set to:`/config/softether`

## How to use

For detailed Information, how to use SoftEther VPN Server please refer to the [SoftEther documentation](https://www.softether.org/4-docs)

### Troubleshooting

If you want to use a dedicated Network Interface Card (NIC) it might be necessary to change the default NIC.
For that, use the SSH & Web Terminal Add-on.

The following command shows the Connections. The first one is the default connection.
```bash
 nmcli connection
```
With this example command you can lower the priority of a connection so an outer one will be the default connection after reboot.
```bash
nmcli connection modify Supervisor\ enp1s0u1u1 ipv4.route-metric 2000
```

## Support

Got questions?

You could also [open an issue here](https://github.com/ToichiKuroba/hassio-softether/issues) GitHub.