![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🍟 Ubuntu - unifi
![size](https://img.shields.io/docker/image-size/11notes/unifi/8.1.113?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/unifi/8.1.113?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/unifi?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-unifi?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-unifi?color=c91cb8) ![stars](https://img.shields.io/docker/stars/11notes/unifi?color=e6a50e)

**Run Unifi Controller (DB included)**

# SYNOPSIS
What can I do with this? This image will provide you a rock solid<sup>1</sup> Unifi controller with included MongoDB (no separate image needed, since its EOL anyway).

# VOLUMES
* **/unifi/var** - Directory of all configuration data and sites

# RUN
```shell
docker run --name unifi \
  -v .../var:/unifi/var \
  -d 11notes/unifi:[tag]
```

# DEFAULT SETTINGS
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /unifi | home directory of user docker |

# ENVIRONMENT
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Show debug information | |

# PARENT IMAGE
* [ubuntu:20.04](https://hub.docker.com/_/ubuntu)

# BUILT WITH
* [unifi](https://community.ui.com/releases)
* [ubuntu](https://alpinelinux.org)

# TIPS
* Only use rootless container runtime (podman, rootless docker)
* Allow non-root ports < 1024 via `echo "net.ipv4.ip_unprivileged_port_start=53" > /etc/sysctl.d/ports.conf`
* Use a reverse proxy like Traefik, Nginx to terminate TLS with a valid certificate
* Use Let’s Encrypt certificates to protect your SSL endpoints

## Disclaimers
* <sup>1</sup> This image will automatically disable anonymous telemetry collected by Ubiquiti by adding a flag (`config.system_cfg.1=system.analytics.anonymous=disabled`) to each sites `config.properties`. You will still have to disable telemetry in the global settings too, to disable *all* telemetry. You can check your telemetry status by SSH’ing into an access point and checking ` grep analytics /tmp/system.cfg`, the output should read `disabled`. Make sure to also DNS block the FQDN `trace.svc.ui.com` in your DNS blocker.

# ElevenNotes<sup>™️</sup>
This image is provided to you at your own risk. Always make backups before updating an image to a new version. Check the changelog for breaking changes.
    