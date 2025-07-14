#!/bin/bash

WATCH_DIR="/var/www/html/voximus/blobs"
LOG_FILE="/var/www/html/voximus/logs/dropwatch.log"
PROCESS_SCRIPT="/var/www/html/voximus/scripts/process_drop.sh"
INTERVAL=2

mkdir -p "$(dirname "$LOG_FILE")"
echo "[`date`] 🧠 Dropwatch initiated. Watching $WATCH_DIR." | tee -a "$LOG_FILE"

LAST_SEEN_FILE=""

while true; do
    sleep "$INTERVAL"
    NEWEST_FILE=$(find "$WATCH_DIR" -type f -printf "%T@ %p\n" | sort -n | tail -1 | cut -d' ' -f2-)

    if [[ "$NEWEST_FILE" != "$LAST_SEEN_FILE" && -n "$NEWEST_FILE" ]]; then
        echo "[`date`] ⚠️  New drop detected: $NEWEST_FILE" | tee -a "$LOG_FILE"
        LAST_SEEN_FILE="$NEWEST_FILE"

        if [[ -x "$PROCESS_SCRIPT" && -f "$NEWEST_FILE" ]]; then
            echo "[`date`] 🗂️  Running $PROCESS_SCRIPT on $NEWEST_FILE..." | tee -a "$LOG_FILE"
            "$PROCESS_SCRIPT" "$NEWEST_FILE"
            echo "[`date`] ✅ process_drop.sh completed." | tee -a "$LOG_FILE"
        else
            echo "[`date`] ❌ ERROR: $PROCESS_SCRIPT not executable or $NEWEST_FILE not found." | tee -a "$LOG_FILE"
        fi
    fi
done

