#!/bin/bash
if [ -z "$1" ]; then
    set -- "/usr/bin/java" \
        -Xmx1024M \
        -jar /usr/lib/unifi/lib/ace.jar
fi

exec "$@"