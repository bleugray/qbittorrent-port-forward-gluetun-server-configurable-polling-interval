#!/bin/sh
set -e

CRON_INTERVAL="${CRON_INTERVAL:-0 * * * *}"
echo "$CRON_INTERVAL /bin/sh /usr/src/app/main.sh" | crontab -

./main.sh
/usr/sbin/crond -f -l 8
