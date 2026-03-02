# ╔═════════════════════════════════════════════════════╗
# ║                       SETUP                         ║
# ╚═════════════════════════════════════════════════════╝
# GLOBAL
  ARG APP_UID=1000 \
      APP_GID=1000 \
      APP_VERSION=0

# :: FOREIGN IMAGES
  FROM 11notes/distroless:localhealth AS distroless-localhealth


# ╔═════════════════════════════════════════════════════╗
# ║                       BUILD                         ║
# ╚═════════════════════════════════════════════════════╝
# :: SOURCE
  FROM alpine AS source
  ARG APP_VERSION \
      TARGETARCH \
      TARGETVARIANT

  RUN set -ex; \
    apk --update --no-cache add \
      jq \
      curl \
      wget \
      unzip; \
    wget -q --show-progress --progress=bar:force -O /tmp/unifi.zip $(curl -s "https://fw-update.ubnt.com/api/firmware?filter=eq~~product~~unifi-controller&filter=eq~~platform~~unix&filter=eq~~channel~~release&sort=-version" | jq -r "._embedded.firmware[] | select(.version | test(\"v${APP_VERSION}\")) | ._links.data.href"); \
    mkdir -p /distroless/usr/lib; \
    mkdir -p /distroless/tmp; \
    unzip -qq /tmp/unifi.zip -d /distroless/usr/lib; \
    mv /distroless/usr/lib/UniFi /distroless/usr/lib/unifi; \
    wget -q --show-progress --progress=bar:force -O /distroless/tmp/mongodb-org-server.deb "https://repo.mongodb.org/apt/ubuntu/dists/noble/mongodb-org/8.2/multiverse/binary-${TARGETARCH}${TARGETVARIANT}/mongodb-org-server_8.2.5_${TARGETARCH}${TARGETVARIANT}.deb";

# :: UNIFI NETWORK APPLICATION & MONGODB
  FROM 11notes/debian:stable AS build
  USER root
  ARG APP_ROOT \
      APP_UID \
      APP_GID

  RUN set -ex; \
    eleven apt install \
      openjdk-25-jre-headless \
      jsvc \
      logrotate \
      libcurl4;

  COPY --from=source /distroless/ /

  RUN set -ex; \
    dpkg -i /tmp/mongodb-org-server.deb;

  RUN set -ex; \
    mkdir -p ${APP_ROOT}/var/sites/default; \
    rm -rf /var/lib/unifi; ln -sf ${APP_ROOT}/var /var/lib/unifi; \
    rm -rf /usr/lib/unifi/run; ln -sf ${APP_ROOT}/run /usr/lib/unifi/run; \
    rm -rf /var/log/unifi; ln -sf ${APP_ROOT}/log /var/log/unifi; \
    rm -rf /usr/lib/unifi/logs; ln -sf ${APP_ROOT}/log /usr/lib/unifi/logs; \
    rm -rf /usr/lib/unifi/data; ln -sf ${APP_ROOT}/var /usr/lib/unifi/data; \
    rm -rf /var/run/unifi; ln -sf ${APP_ROOT}/run /var/run/unifi;

  RUN set -ex; \
    mkdir -p /usr/lib/unifi/data; \
    keytool -genkey -keyalg RSA -alias unifi -keystore /usr/lib/unifi/data/keystore -storepass aircontrolenterprise -keypass aircontrolenterprise -validity 3650 -keysize 4096 -dname "cn=unifi" -ext san=dns:unifi;

  RUN set -ex; \
    chown -R ${APP_UID}:${APP_GID} \
      /usr/lib/unifi/data/keystore \
      ${APP_ROOT};

  RUN set -ex; \
    eleven cleanup;


# :: FILE SYSTEM
  FROM alpine AS file-system
  COPY ./rootfs/ /distroless
  ARG APP_ROOT \
      APP_UID \
      APP_GID

  RUN set -ex; \
    mkdir -p /distroless${APP_ROOT}/var/db; \
    mkdir -p /distroless${APP_ROOT}/log; \
    mkdir -p /distroless${APP_ROOT}/run; \
    chown -R ${APP_UID}:${APP_GID} /distroless${APP_ROOT}; \
    chmod +x -R /distroless/usr/local/bin;


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
    COPY --from=file-system /distroless/ /

# :: PERSISTENT DATA
  VOLUME ["${APP_ROOT}/var"]

# :: MONITORING
  HEALTHCHECK --interval=5s --timeout=2s --start-period=5s \
    CMD ["/usr/local/bin/localhealth", "https://127.0.0.1:8443/", "-I"]

# :: EXECUTE
  USER ${APP_UID}:${APP_GID}
  ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]