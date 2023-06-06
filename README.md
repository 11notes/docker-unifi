# Ubuntu :: Unifi Controller
Run a Unifi Controller based on Ubuntu. Big, heavy, mostly secure and a bit slow (thanks Canonical).

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

## Parent
* [ubuntu:20.04](https://github.com/11notes/docker-alpine)

## Built with
* [Unifi](https://community.ui.com/releases/UniFi-Network-Application-7-4-156/15ac6260-9cd1-4ac3-a91c-4880c1c87882)

## Tips
* Don't bind to ports < 1024 (requires root), use NAT/reverse proxy
* [Permanent Stroage](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS and more