![banner](https://github.com/11notes/defaults/blob/main/static/img/banner.png?raw=true)

# UNIFI
![size](https://img.shields.io/docker/image-size/11notes/unifi/9.3.43?color=0eb305)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![version](https://img.shields.io/docker/v/11notes/unifi/9.3.43?color=eb7a09)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![pulls](https://img.shields.io/docker/pulls/11notes/unifi?color=2b75d6)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)[<img src="https://img.shields.io/github/issues/11notes/docker-UNIFI?color=7842f5">](https://github.com/11notes/docker-UNIFI/issues)![5px](https://github.com/11notes/defaults/blob/main/static/img/transparent5x2px.png?raw=true)![swiss_made](https://img.shields.io/badge/Swiss_Made-FFFFFF?labelColor=FF0000&logo=data:image/svg%2bxml;base64,PHN2ZyB2ZXJzaW9uPSIxIiB3aWR0aD0iNTEyIiBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxyZWN0IHdpZHRoPSIzMiIgaGVpZ2h0PSIzMiIgZmlsbD0idHJhbnNwYXJlbnQiLz4KICA8cGF0aCBkPSJtMTMgNmg2djdoN3Y2aC03djdoLTZ2LTdoLTd2LTZoN3oiIGZpbGw9IiNmZmYiLz4KPC9zdmc+)

Unifi Controller (DB included)

# SYNOPSIS 📖
**What can I do with this?** This image will provide you a rock solid<sup>1</sup> Unifi controller with included MongoDB (no separate image needed, since its EOL anyway).

# UNIQUE VALUE PROPOSITION 💶
**Why should I run this image and not the other image(s) that already exist?** Good question! All the other images on the market that do exactly the same don’t do or offer these options:

> [!IMPORTANT]
>* This image runs as 1000:1000 by default, most other images run everything as root
>* This image is created via a secure, pinned CI/CD process and immune to upstream attacks, most other images have upstream dependencies that can be exploited
>* This image contains a proper health check that verifies the app is actually working, most other images have either no health check or only check if a port is open or ping works
>* This image has an auto update feature that will automatically build the latest version if released, most other image providers do this too slow

If you value security, simplicity and the ability to interact with the maintainer and developer of an image. Using my images is a great start in that direction.

# COMPARISON 🏁
Below you find a comparison between this image and the most used or original one.

| **image** | 11notes/unifi:9.3.43 | linuxserver/unifi-network-application:9.3.43 |
| ---: | :---: | :---: |
| **image size on disk** | 1.3GB | no image found (provider too slow ...) |
| **process UID/GID** | 1000/1000 | ?/? |
| **distroless?** | ❌ | ❌ |
| **rootless?** | ✅ | ❌ |


# VOLUMES 📁
* **/unifi/var** - Directory of all configuration data and sites

# COMPOSE ✂️
```yaml
services:
  unifi:
    image: "11notes/unifi:9.3.43"
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

* [9.3.43](https://hub.docker.com/r/11notes/unifi/tags?name=9.3.43)
* [9.3.43-unraid](https://hub.docker.com/r/11notes/unifi/tags?name=9.3.43-unraid)

### There is no latest tag, what am I supposed to do about updates?
It is of my opinion that the ```:latest``` tag is dangerous. Many times, I’ve introduced **breaking** changes to my images. This would have messed up everything for some people. If you don’t want to change the tag to the latest [semver](https://semver.org/), simply use the short versions of [semver](https://semver.org/). Instead of using ```:9.3.43``` you can use ```:9``` or ```:9.3```. Since on each new version these tags are updated to the latest version of the software, using them is identical to using ```:latest``` but at least fixed to a major or minor version.

If you still insist on having the bleeding edge release of this app, simply use the ```:rolling``` tag, but be warned! You will get the latest version of the app instantly, regardless of breaking changes or security issues or what so ever. You do this at your own risk!

# REGISTRIES ☁️
```
docker pull 11notes/unifi:9.3.43
docker pull ghcr.io/11notes/unifi:9.3.43
docker pull quay.io/11notes/unifi:9.3.43
```

# UNRAID VERSION 🟠
This image supports unraid by default. Simply add **-unraid** to any tag and the image will run as 99:100 instead of 1000:1000 causing no issues on unraid. Enjoy.

# SOURCE 💾
* [11notes/unifi](https://github.com/11notes/docker-UNIFI)

# PARENT IMAGE 🏛️
* [ubuntu:20.04](https://hub.docker.com/_/ubuntu)

# BUILT WITH 🧰
* [unifi](https://community.ui.com/releases/r/network/9.1.120)
* [11notes/util](https://github.com/11notes/docker-util)

# GENERAL TIPS 📌
> [!TIP]
>* Use a reverse proxy like Traefik, Nginx, HAproxy to terminate TLS and to protect your endpoints
>* Use Let’s Encrypt DNS-01 challenge to obtain valid SSL certificates for your services

# DISCLAIMERS
* <sup>1</sup> This image will automatically disable anonymous telemetry collected by Ubiquiti by adding a flag (`config.system_cfg.1=system.analytics.anonymous=disabled`) to each sites `config.properties`. You will still have to disable telemetry in the global settings too, to disable *all* telemetry. You can check your telemetry status by SSH’ing into an access point and checking ` grep analytics /tmp/system.cfg`, the output should read `disabled`. Make sure to also DNS block the FQDN `trace.svc.ui.com` in your DNS blocker.

# SECURITY VULNERABILITIES REPORT ⚡
| ID | Severity | Risk | Vector | Source |
| --- | --- | --- | --- | --- |
| CVE-2024-1351 | critical | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2024-1351) |
| CVE-2020-7692 | critical | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:N](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:N) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2020-7692) |
| CVE-2021-46848 | critical | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2021-46848) |
| CVE-2025-48734 | high | low | [CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-48734) |
| CVE-2025-3085 | high | low | [CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:H/PR:N/UI:N/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-3085) |
| CVE-2023-26604 | high | low | [CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2023-26604) |
| CVE-2024-7553 | high | low | [CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:L/AC:L/PR:L/UI:N/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2024-7553) |
| CVE-2016-20013 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2016-20013) |
| CVE-2017-11164 | high | low | [CVSS:3.0/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.0/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2017-11164) |
| CVE-2017-11692 | high | low | [CVSS:3.0/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.0/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2017-11692) |
| CVE-2019-11777 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2019-11777) |
| CVE-2019-20925 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2019-20925) |
| CVE-2020-7925 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2020-7925) |
| CVE-2020-9283 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2020-9283) |
| CVE-2021-32040 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2021-32040) |
| CVE-2022-3171 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2022-3171) |
| CVE-2022-3509 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2022-3509) |
| CVE-2022-3510 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2022-3510) |
| CVE-2022-41409 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2022-41409) |
| CVE-2023-0437 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2023-0437) |
| CVE-2023-1409 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:N](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:N) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2023-1409) |
| CVE-2024-3372 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2024-3372) |
| CVE-2025-1179 | high | low | [CVSS:3.1/AV:N/AC:H/PR:N/UI:R/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:H/PR:N/UI:R/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-1179) |
| CVE-2025-27820 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:N](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:H/A:N) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-27820) |
| CVE-2025-3083 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-3083) |
| CVE-2025-48988 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:N/I:N/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-48988) |
| CVE-2025-49125 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:N/A:N) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-49125) |
| CVE-2021-22573 | high | low | [CVSS:3.1/AV:N/AC:L/PR:L/UI:R/S:U/C:H/I:H/A:N](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:L/UI:R/S:U/C:H/I:H/A:N) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2021-22573) |
| CVE-2025-46701 | high | low | [CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:L/A:L](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:L/I:L/A:L) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-46701) |
| CVE-2019-2386 | high | low | [CVSS:3.1/AV:N/AC:H/PR:L/UI:R/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:H/PR:L/UI:R/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2019-2386) |
| CVE-2021-32036 | high | low | [CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:N/I:L/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:N/AC:L/PR:L/UI:N/S:U/C:N/I:L/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2021-32036) |
| CVE-2025-5222 | high | low | [CVSS:3.1/AV:L/AC:H/PR:N/UI:R/S:U/C:H/I:H/A:H](https://www.first.org/cvss/calculator/3.1#CVSS:3.1/AV:L/AC:H/PR:N/UI:R/S:U/C:H/I:H/A:H) | [nvd.nist.gov](https://nvd.nist.gov/vuln/detail/CVE-2025-5222) |

# ElevenNotes™️
This image is provided to you at your own risk. Always make backups before updating an image to a different version. Check the [releases](https://github.com/11notes/docker-unifi/releases) for breaking changes. If you have any problems with using this image simply raise an [issue](https://github.com/11notes/docker-unifi/issues), thanks. If you have a question or inputs please create a new [discussion](https://github.com/11notes/docker-unifi/discussions) instead of an issue. You can find all my other repositories on [github](https://github.com/11notes?tab=repositories).

*created 15.07.2025, 07:32:19 (CET)*