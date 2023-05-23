#!/bin/sh
  if [ -z "$1" ]; then
    cd /usr/lib/unifi
    set -- "/usr/bin/java" \
      -Dfile.encoding=UTF-8 \
      -Djava.awt.headless=true \
      -Dapple.awt.UIElement=true \
      -Dunifi.core.enabled=false \
      -XX:+ExitOnOutOfMemoryError \
      -XX:+CrashOnOutOfMemoryError \
      -XX:ErrorFile=/var/lib/unifi/logs/hs_err_pid%p.log \
      -Dunifi.datadir=/var/lib/unifi/data \
      -Dunifi.logdir=/var/lib/unifi/logs \
      -Dunifi.rundir=/var/lib/unifi/run \
      -Dlog4j2.formatMsgNoLookups=true \
      -Xmx1024M \
      -XX:+UseParallelGC \
      -jar /usr/lib/unifi/lib/ace.jar start
  fi

  exec "$@"