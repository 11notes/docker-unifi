# :: Header
  FROM ubuntu:20.04
  ENV DEBIAN_FRONTEND=noninteractive
  ENV UNIFI=7.3.83

# :: Run
  USER root

  # :: prepare
    RUN set -ex; \
      mkdir -p /unifi; \
      mkdir -p /unifi/var;

  # :: install
  # https://community.ui.com/RELEASES UniFi Network Application
    ADD https://dl.ui.com/unifi/${UNIFI}/unifi_sysvinit_all.deb /tmp/unifi.deb

    RUN set -ex; \
      apt update -y; apt upgrade -y; apt install -y \
        mongodb=1:3.6.9+really3.6.8+90~g8e540c0b6d-0ubuntu5 \
        openjdk-11-jre-headless \
        binutils \
        jsvc \
        curl \
        libcap2 \
        liblog4j2-java \
        tzdata \
        logrotate; \
      dpkg -i /tmp/unifi.deb; \
      rm -rf /usr/lib/unifi/data; \
      ln -sf /unifi/var /usr/lib/unifi/data; \
      ln -sf /unifi/log /var/lib/unifi/logs;

  # :: copy root filesystem changes
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: docker -u 1000:1000 (no root initiative)
    RUN set -ex; \
      NOROOT_USER="unifi" \
      NOROOT_UID="$(id -u ${NOROOT_USER})"; \
      NOROOT_GID="$(id -g ${NOROOT_USER})"; \
      find / -not -path "/proc/*" -user ${NOROOT_UID} -exec chown -h -R 1000:1000 {} \;;\
      find / -not -path "/proc/*" -group ${NOROOT_GID} -exec chown -h -R 1000:1000 {} \;;

    RUN set -ex; \
      usermod -u 1000 unifi; \
      groupmod -g 1000 unifi; \
      chown -R unifi:unifi \
        /unifi \
        /usr/lib/unifi \
        /var/run/unifi \
        /var/lib/unifi \
        /var/log/unifi;      

# :: Volumes
  VOLUME ["/unifi/var"]

# :: Monitor
  HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
  USER unifi
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]