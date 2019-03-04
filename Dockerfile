# :: Header
FROM ubuntu:16.04
ENV unifiVersion=5.10.19
ARG DEBIAN_FRONTEND=noninteractive


# :: Run
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

RUN apt-get update \
    && apt-get -y install binutils jsvc mongodb-org openjdk-8-jre-headless curl

RUN apt-get install -y wget \
    && wget -O /tmp/unifi.deb https://dl.ubnt.com/unifi/${unifiVersion}/unifi_sysvinit_all.deb \
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