![banner](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/banner/README.png)

# UNIFI
![size](https://img.shields.io/badge/image_size-902MB-green?color=%2338ad2d)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/markdown/transparent5x2px.png)![pulls](https://img.shields.io/docker/pulls/11notes/unifi?color=2b75d6)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/markdown/transparent5x2px.png)[<img src="https://img.shields.io/github/issues/11notes/docker-unifi?color=7842f5">](https://github.com/11notes/docker-unifi/issues)![5px](https://raw.githubusercontent.com/11notes/static/refs/heads/main/img/markdown/transparent5x2px.png)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxyZWN0IHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgZmlsbD0idHJhbnNwYXJlbnQiLz4KICA8cGF0aCBkPSJtMTMgNmg2djdoN3Y2aC03djdoLTZ2LTdoLTd2LTZoN3oiIGZpbGw9IiNmZmYiLz4KPC9zdmc+)

run Unifi Controller rootless.

# INTRODUCTION 📢

The UniFi Network Controller is the free, central software hub for Ubiquiti's UniFi ecosystem, allowing you to discover, configure, monitor, and manage all your UniFi devices (like Access Points, Switches, Gateways) from a single, user-friendly dashboard, providing insights, performance stats, and unified control for your entire network, whether it's running on a dedicated device (Cloud Key, UDM) or installed software.

# CAUTION ⚠️
> [!CAUTION]
>This image, sadly, is EOL. Please create a backup of your Unifi controller, download it, setup a new [Unifi Network Application image](https://github.com/11notes/docker-unifi-network-application) and restore your backup there. All Versions after 10.0.162 will only be published on the new image. Consider this image EOL! The auto update and build job is removed.

# SYNOPSIS 📖
**What can I do with this?** This image will provide you a rock solid<sup>1</sup> Unifi controller with included MongoDB (no separate image needed, since its EOL anyway).

# UNIQUE VALUE PROPOSITION 💶
**Why should I run this image and not the other image(s) that already exist?** Good question! Because ...

> [!IMPORTANT]
>* ... this image runs [rootless](https://github.com/11notes/RTFM/blob/main/linux/container/image/rootless.md) as 1000:1000
>* ... this image is auto updated to the latest version via CI/CD
>* ... this image has a health check
>* ... this image runs read-only
>* ... this image is created via a secure and pinned CI/CD process

If you value security, simplicity and optimizations to the extreme, then this image might be for you.

# VOLUMES 📁
* **/unifi/var** - Directory of all configuration data and sites

# COMPOSE ✂️
```yaml
name: "unifi"

x-lockdown: &lockdown
  # prevents write access to the image itself
  read_only: true
  # prevents any process within the container to gain more privileges
  security_opt:
    - "no-new-privileges=true"

services:
  controller:
    image: "11notes/unifi:10.0.162"
    <<: *lockdown
    environment:
      TZ: "Europe/Zurich"
    volumes:
      - "controller.var:/unifi/var"
    tmpfs:
      - "/unifi/log:uid=1000,gid=1000"
      - "/unifi/run:uid=1000,gid=1000"
    ports:
      - "3000:8443/tcp"
    networks:
      frontend:
    restart: always

volumes:
  controller.var:

networks:
  frontend:
```
To find out how you can change the default UID/GID of this container image, consult the [RTFM](https://github.com/11notes/RTFM/blob/main/linux/container/image/11notes/how-to.changeUIDGID.md#change-uidgid-the-correct-way).

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

# MAIN TAGS 🏷️
These are the main tags for the image. There is also a tag for each commit and its shorthand sha256 value.

* [10.0.162](https://hub.docker.com/r/11notes/unifi/tags?name=10.0.162)
* [10.0.162-unraid](https://hub.docker.com/r/11notes/unifi/tags?name=10.0.162-unraid)
* [10.0.162-nobody](https://hub.docker.com/r/11notes/unifi/tags?name=10.0.162-nobody)

### There is no latest tag, what am I supposed to do about updates?
It is my opinion that the ```:latest``` tag is a bad habbit and should not be used at all. Many developers introduce **breaking changes** in new releases. This would messed up everything for people who use ```:latest```. If you don’t want to change the tag to the latest [semver](https://semver.org/), simply use the short versions of [semver](https://semver.org/). Instead of using ```:10.0.162``` you can use ```:10``` or ```:10.0```. Since on each new version these tags are updated to the latest version of the software, using them is identical to using ```:latest``` but at least fixed to a major or minor version. Which in theory should not introduce breaking changes.

If you still insist on having the bleeding edge release of this app, simply use the ```:rolling``` tag, but be warned! You will get the latest version of the app instantly, regardless of breaking changes or security issues or what so ever. You do this at your own risk!

# REGISTRIES ☁️
```
docker pull 11notes/unifi:10.0.162
docker pull ghcr.io/11notes/unifi:10.0.162
docker pull quay.io/11notes/unifi:10.0.162
```

# UNRAID VERSION 🟠
This image supports unraid by default. Simply add **-unraid** to any tag and the image will run as 99:100 instead of 1000:1000.

# NOBODY VERSION 👻
This image supports nobody by default. Simply add **-nobody** to any tag and the image will run as 65534:65534 instead of 1000:1000.

# SOURCE 💾
* [11notes/unifi](https://github.com/11notes/docker-unifi)

# PARENT IMAGE 🏛️
* [ubuntu:20.04](https://hub.docker.com/_/ubuntu)

# BUILT WITH 🧰
* [unifi](https://community.ui.com/releases/r/network/10.0.162)
* [11notes/util](https://github.com/11notes/docker-util)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# DISCLAIMERS
* <sup>1</sup> This image will automatically disable anonymous telemetry collected by Ubiquiti by adding a flag (`config.system_cfg.1=system.analytics.anonymous=disabled`) to each sites `config.properties`. You will still have to disable telemetry in the global settings too, to disable *all* telemetry. You can check your telemetry status by SSH’ing into an access point and checking ` grep analytics /tmp/system.cfg`, the output should read `disabled`. Make sure to also DNS block the FQDN `trace.svc.ui.com` in your DNS blocker.

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-unifi/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-unifi/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-unifi/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 23.02.2026, 22:24:01 (CET)*