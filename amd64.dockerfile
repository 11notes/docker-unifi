# :: Header
FROM ubuntu:20.04
ENV UNIFI=7.2.95
ARG DEBIAN_FRONTEND=noninteractive


# :: Run
    USER root

    # :: prepare
        RUN set -ex; \
            mkdir -p /unifi;

    # :: install
        ADD https://dl.ui.com/unifi/${UNIFI}/unifi_sysvinit_all.deb /tmp/unifi.deb

        RUN set -ex; \
            apt-get update -y; apt-get install -y \
                mongodb=1:3.6.9+really3.6.8+90~g8e540c0b6d-0ubuntu5 \
                openjdk-8-jre-headless \
                binutils \
                jsvc \
                curl \
                libcap2 \
                logrotate; \
           dpkg -i /tmp/unifi.deb; \
           ln -s /var/lib/unifi /unifi/var;


    # :: copy root filesystem changes
        COPY ./rootfs /

    # :: docker -u 1000:1000 (no root initiative)
        RUN APP_UID="$(id -u unifi)" \
            && APP_GID="$(id -g unifi)" \
            && find / -not -path "/proc/*" -user $APP_UID -exec chown -h -R 1000:1000 {} \;\
            && find / -not -path "/proc/*" -group $APP_GID -exec chown -h -R 1000:1000 {} \;
        RUN usermod -u 1000 unifi \
            && groupmod -g 1000 unifi
        RUN chown -R unifi:unifi \
                /usr/lib/unifi \
                /var/run/unifi \
                /var/lib/unifi \
                /var/log/unifi

# :: Volumes
    VOLUME ["/unifi/var"]


# :: Monitor
    RUN set -ex; chmod +x /usr/local/bin/healthcheck.sh
    HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
    RUN set -ex; chmod +x /usr/local/bin/entrypoint.sh
    USER unifi
    ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]