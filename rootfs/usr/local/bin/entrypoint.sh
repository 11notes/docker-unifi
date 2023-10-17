#!/bin/sh
  if [ -z "$1" ]; then
    cd /usr/lib/unifi
    set -- "/usr/bin/java" \
      -Dfile.encoding=UTF-8 \
      -Djava.awt.headless=true \
      -Dapple.awt.UIElement=true \
      -XX:+UseParallelGC \
      -XX:+ExitOnOutOfMemoryError \
      -XX:+CrashOnOutOfMemoryError \
      -XX:ErrorFile=/var/lib/unifi/logs/hs_err_pid%p.log \
      -Dunifi.datadir=/var/lib/unifi/data \
      -Dunifi.logdir=/var/lib/unifi/logs \
      -Dunifi.rundir=/var/lib/unifi/run \
      -Dlog4j2.formatMsgNoLookups=true \
      --add-opens java.base/java.lang=ALL-UNNAMED \
      --add-opens java.base/java.time=ALL-UNNAMED \
      --add-opens java.base/sun.security.util=ALL-UNNAMED \
      --add-opens java.base/java.io=ALL-UNNAMED \
      --add-opens java.rmi/sun.rmi.transport=ALL-UNNAMED \
      -Xmx1024M \
      -XX:+UseParallelGC \
      -jar /usr/lib/unifi/lib/ace.jar start
  fi

  exec "$@"