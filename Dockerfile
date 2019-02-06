# :: Header
FROM ubuntu:16.04
ENV unifiVersion=5.10.12-20644d4901
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

COPY ./source/healthcheck.sh /usr/local/bin/healthcheck.sh

# :: docker -u 1000:1000 (no root initiative)
RUN groupadd -r ubiquiti -g 1000 \
    && useradd --no-log-init -r -u 1000 -g 1000 ubiquiti

RUN chown -R ubiquiti:ubiquiti \
    /usr/lib/unifi \
    /var/run/unifi \
    /var/lib/unifi


# :: Volumes
VOLUME ["/usr/lib/unifi/data", "/usr/lib/unifi/logs"]

# :: Monitor
HEALTHCHECK CMD /usr/local/bin/healthcheck.sh || exit 1

# :: Start
USER ubiquiti
ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]