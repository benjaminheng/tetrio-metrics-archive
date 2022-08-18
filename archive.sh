#!/bin/bash

git pull
sqlite3 $1 "select played_at, time_ms, finesse_percent, total_pieces, pieces_per_second from gamemode_40l order by played_at desc" --csv > gamemode_40l.csv
git add gamemode_40l.csv
git commit -m "Update gamemode_40l.csv"
git push
