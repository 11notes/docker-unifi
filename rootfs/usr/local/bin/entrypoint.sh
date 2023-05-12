#!/bin/sh
  if [ -z "$1" ]; then
    set -- "/usr/bin/java" \
      -Dlog4j2.formatMsgNoLookups=true \
      -jar /usr/lib/unifi/lib/ace.jar start
  else
    case
      repair)
        /usr/bin/mongod --dbpath /usr/lib/unifi/data/db --smallfiles --logpath /usr/lib/unifi/logs/server.log --repair
      ;;
    esac
  fi

  exec "$@"