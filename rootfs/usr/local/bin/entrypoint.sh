#!/bin/bash
if [ -z "$1" ]; then
    set -- "/usr/bin/java" \
        -Dlog4j2.formatMsgNoLookups=true \
        -jar /usr/lib/unifi/lib/ace.jar start
fi

exec "$@"