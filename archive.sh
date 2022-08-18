#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: ./archive.sh <sqlite3-db>"
    exit 1
fi

git pull
sqlite3 $1 "select played_at, time_ms, finesse_percent, total_pieces, pieces_per_second from gamemode_40l order by played_at desc" --csv --header > gamemode_40l.csv
git add gamemode_40l.csv
git commit -m "Update gamemode_40l.csv"
git push
