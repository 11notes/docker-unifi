# ------ Header ------ #
FROM ubuntu:16.04

# ------ set environment varialbes ------ #
ENV dirUniFiSource=/usr/lib/unifi \
    dirUniFiVar=/var/lib/unifi \
    dirUniFiRun=/var/run/unifi \
    dirUniFiLog=/var/log/unifi

#   // create symbolic links to UniFi data folders
RUN ln -s ${dirUniFiSource}/data ${dirUniFiVar} && \
    ln -s ${dirUniFiSource}/run ${dirUniFiRun} && \
    ln -s ${dirUniFiSource}/logs ${dirUniFiLog}

# ------ define volumes ------ #
VOLUME ["${dirUniFiVar}", "${dirUniFiLog}"]

RUN echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927 

#   // create downloads directory
RUN mkdir -p /var/jdownloader2/downloads \
#   // create working directory for jdownloader
    && mkdir -p /var/jdownloader2/java \
#   // download latest jdownloader version
    && wget --quiet -O /var/jdownloader2/java/JDownloader.jar http://installer.jdownloader.org/JDownloader.jar \
#   // set propper privileges to jdownloader.jar
    && chmod +x /var/jdownloader2/java/JDownloader.jar \
#   // create symbolic link for /usr/bin/jdownloader
    && ln -s /var/jdownloader2/java/JDownloader.jar /usr/bin/jDownloader \
#   // create symbolic link for cfg to config (beautification)
    && ln -s /var/jdownloader2/java/cfg /var/jdownloader2/config \
#   // create symbolic link for default downloads directory
    && ln -s /var/jdownloader2/downloads /root/Downloads

# ------ define volumes ------ #
VOLUME ["/var/jdownloader2/downloads", "/var/jdownloader2/config"]

# ------ run once for update of packages and core ------ #
RUN /usr/bin/java -Djava.awt.headless=true -jar /usr/bin/jDownloader

# ------ entrypoint for container ------ #
ENTRYPOINT ["/usr/bin/java", "-Djava.awt.headless=true", "-jar", "/usr/bin/jDownloader"]
CMD ["start"]