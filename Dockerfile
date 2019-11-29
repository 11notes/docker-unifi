# :: Header
FROM ubuntu:16.04
ENV unifiVersion=5.12.35
ENV unifiReleaseCandidate=
ARG DEBIAN_FRONTEND=noninteractive


# :: Run
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6

RUN apt-get update \
    && apt-get -y install binutils jsvc mongodb-org openjdk-8-jre-headless curl

RUN if [ "x${unifiReleaseCandidate}" = "x" ] ; then \
        unifiReleaseURI="https://dl.ui.com/unifi/${unifiVersion}/unifi_sysvinit_all.deb"; \
    else \
        unifiReleaseURI="https://dl.ui.com/unifi/${unifiVersion}-${unifiReleaseCandidate}/unifi_sysvinit_all.deb"; \
    fi \
    &&apt-get install -y wget \
    && wget -O /tmp/unifi.deb "${unifiReleaseURI}" \
    && dpkg -i /tmp/unifi.deb \
    && rm -f /tmp/unifi.deb

ADD ./source/healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

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
VOLUME ["/usr/lib/unifi/data", "/usr/lib/unifi/logs"]


# :: Monitor
HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1


# :: Start
USER unifi
ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]