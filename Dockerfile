# ------ HEADER ------ #
FROM ubuntu:16.04
ENV unifiVersion=5.6.30
ARG DEBIAN_FRONTEND=noninteractive

# ------ RUN  ------ #
RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

RUN apt-get update \
    && apt-get -y install binutils jsvc mongodb-org openjdk-8-jre-headless

RUN apt-get install -y wget \
    && wget -O /tmp/unifi.deb http://dl.ubnt.com/unifi/${unifiVersion}/unifi_sysvinit_all.deb \
    && dpkg -i /tmp/unifi.deb \
    && rm -f /tmp/unifi.deb

# ------ VOLUMES ------ #
VOLUME ["/var/lib/unifi"]

# ------ CMD/START ------ #
ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]