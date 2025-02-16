#!/bin/bash
# Qbittorrent and Sonarr settings
QB_URL="http://localhost:8080"
QB_USER="USERNAME"
QB_PASS="PASSWORD"
COOKIE_FILE="/tmp/qb_cookie"
SONARR_URL="http://172.17.0.1:8989"
SONARR_API_KEY="APIKEY"


refresh_cookie() {
    echo "Logging into Qbittorrent..."
    curl -s -X POST -c "$COOKIE_FILE" "$QB_URL/api/v2/auth/login" \
         --data "username=$QB_USER&password=$QB_PASS"
}


if [ ! -f "$COOKIE_FILE" ]; then
    refresh_cookie
fi


TORRENTS=$(curl -s --cookie "$COOKIE_FILE" "$QB_URL/api/v2/torrents/info" | jq -r '.[] | select(.size==0) | .hash')


if [ -z "$TORRENTS" ]; then
    echo "No empty torrents found."
    exit 0
fi


for TORRENT in $TORRENTS; do
    echo "Deleting empty torrent: $TORRENT"
    curl -s -X POST --cookie "$COOKIE_FILE" "$QB_URL/api/v2/torrents/delete" --data "hashes=$TORRENT&deleteFiles=true"
done


echo "Refreshing Sonarr queue..."
curl -s -X POST "$SONARR_URL/api/v3/command" \
     -H "X-Api-Key: $SONARR_API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"name": "RefreshMonitoredDownloads"}'


echo "Triggering Sonarr Rescan..."
curl -s -X POST "$SONARR_URL/api/v3/command" \
     -H "X-Api-Key: $SONARR_API_KEY" \
     -H "Content-Type: application/json" \
     --data '{"name": "RescanSeries"}'

echo "Finished removing empty torrents and refreshing Sonarr."
