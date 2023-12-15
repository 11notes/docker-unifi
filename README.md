# Ubuntu :: Unifi Controller
![size](https://img.shields.io/docker/image-size/11notes/unifi/8.0.24?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/unifi?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/unifi?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-unifi?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-unifi?color=c91cb8)

Run a Unifi Controller based on Ubuntu. Big, heavy, mostly secure<sup>1</sup> and a bit slow 🍟

## Volumes
* **/unifi/var** - Directory of all configuration data and sites

## Run
```shell
docker run --name unifi \
  -v ../var:/unifi/var \
  -d 11notes/unifi:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 (99 on unraid) | user id |
| `gid` | 1000 (100 on unraid) | group id |
| `home` | /unifi | home directory of user docker |

## Environment
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | null |

## Parent Image
* [ubuntu:20.04](https://github.com/11notes/docker-alpine)

## Built with and thanks to
* [Unifi Controller](https://community.ui.com/releases)
* [Ubuntu](https://hub.docker.com/_/ubuntu)

## Tips
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)

## Disclaimers
* <sup>1</sup> This image will automatically disable anonymous telemetry collected by Ubiquiti by adding a flag (`config.system_cfg.1=system.analytics.anonymous=disabled`) to each sites `config.properties`. You will still have to disable telemetry in the global settings too, to disable *all* telemetry.