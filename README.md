# docker-unifi

Small container with unifi controller installed

## Volumes
* /unifi/etc - Purpose: Holds all configuration data and sites

## Run
```shell
docker run --name unifi \
    -v /.../var:/unifi/var \
    -d 11notes/unifi:[tag]
```

## Docker -u 1000:1000 (no root initiative)

As part to make containers more secure, this container will not run as root, but as uid:gid 1000:1000

## Build with
* [Ubuntu](https://hub.docker.com/_/ubuntu) - Parent container
* [Ubiquiti Unifi SDN](https://community.ubnt.com/t5/UniFi-Updates-Blog/bg-p/Blog_UniFi) - Unifi Update Blog

## Tips

* Don't bind to ports < 1024 (requires root), use NAT
* [Permanent Storge with NFS/CIFS/...](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS/...