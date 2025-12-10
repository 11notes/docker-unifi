# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
# GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000

# :: FOREIGN IMAGES
  FROM 11notes/util AS util
  FROM 11notes/distroless:localhealth AS distroless-localhealth


# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: UNIFI & MONGODB
  FROM ubuntu:20.04 AS build
  ARG DEBIAN_FRONTEND=noninteractive \
      APP_VERSION \
      APP_ROOT \
      APP_UID \
      APP_GID

  ADD https://dl.ui.com/unifi/${APP_VERSION}/unifi_sysvinit_all.deb /tmp/unifi.deb
  COPY ./rootfs /
  COPY --from=util / /


  RUN set -ex; \
    apt update -y; \
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
      logrotate; \
    dpkg -i /tmp/unifi.deb; \
    rm -rf /tmp/unifi.deb;

  RUN set -ex; \
    rm -rf /var/lib/unifi; ln -sf ${APP_ROOT}/var /var/lib/unifi; \
    mkdir -p ${APP_ROOT}/var/sites/default; \
    rm -rf /var/log/unifi; ln -sf ${APP_ROOT}/log /var/log/unifi; \
    rm -rf /var/log/mongodb; ln -sf ${APP_ROOT}/log /var/log/mongodb; \
    rm -rf /var/run/unifi; ln -sf ${APP_ROOT}/run /var/run/unifi;

  RUN set -ex; \
    eleven changeUserToDocker unifi;

  RUN set -ex; \
    rm -rf /var/log/unifi_package.log;

  RUN set -ex; \
    chmod +x -R /usr/local/bin; \
    usermod -d ${APP_ROOT} docker; \
    chown -R ${APP_UID}:${APP_GID} \
      ${APP_ROOT}


# ╔═════════════════════════════════════════════════════╗
# ║                       IMAGE                         ║
# ╚═════════════════════════════════════════════════════╝
# :: HEADER
  FROM scratch

  # :: default arguments
    ARG TARGETPLATFORM \
        TARGETOS \
        TARGETARCH \
        TARGETVARIANT \
        APP_IMAGE \
        APP_NAME \
        APP_VERSION \
        APP_ROOT \
        APP_UID \
        APP_GID \
        APP_NO_CACHE

  # :: default environment
    ENV APP_IMAGE=${APP_IMAGE} \
        APP_NAME=${APP_NAME} \
        APP_VERSION=${APP_VERSION} \
        APP_ROOT=${APP_ROOT}

  # :: multi-stage
    COPY --from=distroless-localhealth / /
    COPY --from=build / /

# :: PERSISTENT DATA
  VOLUME ["${APP_ROOT}/var"]

# :: MONITORING
  HEALTHCHECK --interval=5s --timeout=2s --start-period=5s \
    CMD ["/usr/local/bin/localhealth", "https://127.0.0.1:8443/", "-I"]

# :: EXECUTE
  USER ${APP_UID}:${APP_GID}
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]