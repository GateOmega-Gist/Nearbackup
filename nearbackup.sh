#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)
DATADIR=/home/nearbackup/.near/data
BACKUPDIR=/home/nearbackup/.near/backups/near_${DATE}

mkdir $BACKUPDIR

sudo systemctl stop neard

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts

    cp -rf $DATADIR ${BACKUPDIR}/

    # Submit backup completion status, you can use healthchecks.io, betteruptime.com or other services
    # Example
    # curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/xXXXxXXx-XxXx-XXXX-XXXx-...

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard

echo "NEAR node was started" | ts
