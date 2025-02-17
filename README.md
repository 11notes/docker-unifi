![Banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# 🍟 unifi on Ubuntu
[<img src="https://img.shields.io/badge/github-source-blue?logo=github&color=040308">](https://github.com/11notes/docker-unifi)![size](https://img.shields.io/docker/image-size/11notes/unifi/9.0.114?color=0eb305)![version](https://img.shields.io/docker/v/11notes/unifi/9.0.114?color=eb7a09)![pulls](https://img.shields.io/docker/pulls/11notes/unifi?color=2b75d6)[<img src="https://img.shields.io/github/issues/11notes/docker-unifi?color=7842f5">](https://github.com/11notes/docker-unifi/issues)

**Unifi Controller (DB included)**

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [9.0.114](https://hub.docker.com/r/11notes/unifi/tags?name=9.0.114)
* [latest](https://hub.docker.com/r/11notes/unifi/tags?name=latest)
* [9.0.114-unraid](https://hub.docker.com/r/11notes/unifi/tags?name=9.0.114-unraid)
* [latest-unraid](https://hub.docker.com/r/11notes/unifi/tags?name=latest-unraid)


# SYNOPSIS 📖
**What can I do with this?** This image will provide you a rock solid<sup>1</sup> Unifi controller with included MongoDB (no separate image needed, since its EOL anyway).

# VOLUMES 📁
* **/unifi/var** - Directory of all configuration data and sites

# COMPOSE ✂️
```yaml
services:
  unifi:
    image: "11notes/unifi:9.0.114"
    container_name: "unifi"
    environment:
      TZ: "Europe/Zurich"
    volumes:
      - "var:/unifi/var"
    networks:
      macvlan:
        ipv4_address: 10.255.255.1
    restart: always

volumes:
  var:
  
networks:
  macvlan:
    driver: "macvlan"
    driver_opts:
      parent: "eth0"
    ipam:
      config:
        - subnet: "10.255.255.0/24"
          gateway: "10.255.255.254"
```

# UNRAID VERSION 🟠
This image supports unraid by default. Simply add **-unraid** to any tag and the image will run as 99:100 instead of 1000:1000 causing no issues on unraid. Enjoy.


# DEFAULT SETTINGS 🗃️
| Parameter | Value | Description |
| --- | --- | --- |
| `user` | docker | user name |
| `uid` | 1000 | [user identifier](https://en.wikipedia.org/wiki/User_identifier) |
| `gid` | 1000 | [group identifier](https://en.wikipedia.org/wiki/Group_identifier) |
| `home` | /unifi | home directory of user docker |

# ENVIRONMENT 📝
| Parameter | Value | Default |
| --- | --- | --- |
| `TZ` | [Time Zone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) | |
| `DEBUG` | Will activate debug option for container image and app (if available) | |

# SOURCE 💾
* [11notes/unifi](https://github.com/11notes/docker-unifi)

# PARENT IMAGE 🏛️
* [ubuntu:20.04](https://hub.docker.com/_/ubuntu)

# BUILT WITH 🧰
* [unifi](https://community.ui.com/releases)
* [ubuntu](https://alpinelinux.org)

# GENERAL TIPS 📌
* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

## Disclaimers
* <sup>1</sup> This image will automatically disable anonymous telemetry collected by Ubiquiti by adding a flag (`config.system_cfg.1=system.analytics.anonymous=disabled`) to each sites `config.properties`. You will still have to disable telemetry in the global settings too, to disable *all* telemetry. You can check your telemetry status by SSH’ing into an access point and checking ` grep analytics /tmp/system.cfg`, the output should read `disabled`. Make sure to also DNS block the FQDN `trace.svc.ui.com` in your DNS blocker.

    
# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-unifi/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-unifi/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-unifi/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).