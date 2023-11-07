# Ubuntu :: Unifi Controller
![size](https://img.shields.io/docker/image-size/11notes/unifi/7.5.187?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/unifi?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/unifi?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-unifi?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-unifi?color=c91cb8)

Run a Unifi Controller based on Ubuntu. Big, heavy, mostly secure and a bit slow 🍟

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
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
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
* Use reverse proxy for valid SSL certificate
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)