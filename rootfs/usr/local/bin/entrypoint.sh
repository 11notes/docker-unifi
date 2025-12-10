#!/bin/sh
  DISABLE_ANONYMOUS_TELEMETRY="config.system_cfg.1=system.analytics.anonymous=disabled"

  for SITE in ${APP_ROOT}/var/sites/*; do
    if [ -d ${SITE} ]; then
      CONFIG="${SITE}/config.properties"
      if [ ! -f ${CONFIG} ]; then
        echo ${DISABLE_ANONYMOUS_TELEMETRY} > ${CONFIG}
        eleven log info "disable telemetry for site ${SITE}"
      else
        if ! cat ${CONFIG} | grep -q 'config.system_cfg.1'; then
          echo ${DISABLE_ANONYMOUS_TELEMETRY} > ${CONFIG}
          eleven log info "disable telemetry for site ${SITE}"
        fi
      fi
    fi
  done

  if [ -z "${1}" ]; then
    cd /usr/lib/unifi
    set -- "/usr/bin/java" \
      -Xmx1024M \
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
      -jar /usr/lib/unifi/lib/ace.jar start

    eleven log start
  fi

  exec "$@"