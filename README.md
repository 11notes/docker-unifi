# Ubuntu :: Unifi Controller
![size](https://img.shields.io/docker/image-size/11notes/unifi/7.5.176?color=0eb305) ![version](https://img.shields.io/docker/v/11notes/unifi?color=eb7a09) ![pulls](https://img.shields.io/docker/pulls/11notes/unifi?color=2b75d6) ![activity](https://img.shields.io/github/commit-activity/m/11notes/docker-unifi?color=c91cb8) ![commit-last](https://img.shields.io/github/last-commit/11notes/docker-unifi?color=c91cb8)

Run a Unifi Controller based on Ubuntu. Big, heavy, mostly secure and a bit slow 🍟

## Volumes
* **/unifi/var** - Directory of all configuration data and sites

## Run
```shell
docker run --name unifi \
  -v ../unifi/var:/unifi/var \
  -d 11notes/unifi:[tag]
```

## Defaults
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user docker |
| `uid` | 1000 | user id 1000 |
| `gid` | 1000 | group id 1000 |
| `home` | /unifi | home directory of user docker |

## Parent Image
* [ubuntu:20.04](https://github.com/11notes/docker-alpine)

## Built with and thanks to
* [Unifi](https://community.ui.com/releases/UniFi-Network-Application-7-4-156/15ac6260-9cd1-4ac3-a91c-4880c1c87882)

## Tips
* Use reverse proxy for valid SSL certificate
* Only use rootless container runtime (podman, rootless docker)
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy (haproxy, traefik, nginx)