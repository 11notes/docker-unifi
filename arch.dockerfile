# :: Util
  FROM 11notes/util AS util

# :: Header
  FROM ubuntu:20.04

  # :: arguments
    ARG TARGETARCH
    ARG APP_IMAGE
    ARG APP_NAME
    ARG APP_VERSION
    ARG APP_ROOT
    ARG APP_UID
    ARG APP_GID
    ARG APP_RC
    
    ARG DEBIAN_FRONTEND=noninteractive

  # :: environment
    ENV APP_IMAGE=${APP_IMAGE}
    ENV APP_NAME=${APP_NAME}
    ENV APP_VERSION=${APP_VERSION}
    ENV APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=util /usr/local/bin/ /usr/local/bin

# :: Run
  USER root
  RUN eleven printenv;

  # :: update image
    RUN set -ex; \
      apt update -y; \
      apt upgrade -y;

  # :: install application
    RUN set -ex; \
      mkdir -p ${APP_ROOT};

    ADD https://dl.ui.com/unifi/${APP_VERSION}${APP_RC}/unifi_sysvinit_all.deb /tmp/unifi.deb

    RUN set -ex; \
      apt install -y \
        mongodb=1:3.6.9+really3.6.8+90~g8e540c0b6d-0ubuntu5 \
        openjdk-17-jre-headless \
        binutils \
        jsvc \
        curl \
        libcap2 \
        liblog4j2-java \
        tzdata \
        gosu \
        logrotate;

    RUN set -ex; \
      dpkg -i /tmp/unifi.deb; \
      ln -s /var/lib/unifi ${APP_ROOT}/var; \
      ln -s /var/log/unifi ${APP_ROOT}/log; \
      mkdir -p ${APP_ROOT}/var/sites/default; \
      rm -rf /tmp/unifi.deb;

  # :: copy filesystem changes and set correct permissions
    COPY ./rootfs /
    RUN set -ex; \
      chmod +x -R /usr/local/bin;

  # :: change uid/gid
    RUN set -ex; \
      eleven changeUserToDocker unifi

  # :: change home path for existing user and set correct permission
    RUN set -ex; \
      usermod -d ${APP_ROOT} docker; \
      chown -R 1000:1000 \
        ${APP_ROOT} \
        /usr/lib/unifi \
        /var/run/unifi \
        /var/lib/unifi \
        /var/log/unifi;

  # :: support unraid
    RUN set -ex; \
      eleven unraid;

# :: Volumes
  VOLUME ["${APP_ROOT}/var"]

# :: Monitor
  HEALTHCHECK --interval=5s --timeout=2s CMD curl -X GET -kILs --fail https://localhost:8443 || exit 1

# :: Start
  USER docker
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]