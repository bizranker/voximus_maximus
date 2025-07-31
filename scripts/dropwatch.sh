#!/bin/bash

WATCH_DIR="/var/www/html/voximus/blobs"
STATE_FILE="/var/www/html/voximus/scripts/.dropwatch_state"
LOG_FILE="/var/log/dropwatch.log"
ALERT_EMAIL="naga@usreliance.com"

# Calculate current hash of directory (files only)
CURRENT_HASH=$(ls -lR --time-style=long-iso "$WATCH_DIR" | md5sum | awk '{print $1}')

# Check if previous hash exists
if [ -f "$STATE_FILE" ]; then
    PREV_HASH=$(cat "$STATE_FILE")
else
    PREV_HASH=""
fi

# If hashes differ, send alert
if [ "$CURRENT_HASH" != "$PREV_HASH" ]; then
    echo "[`date`] ⚠ Change detected in $WATCH_DIR" | tee -a "$LOG_FILE"
    echo "Directory $WATCH_DIR has changed at $(date)." | mail -s "Dropwatch Alert: Change Detected" "$ALERT_EMAIL"
    echo "$CURRENT_HASH" > "$STATE_FILE"
else
    echo "[`date`] ✅ No change detected." >> "$LOG_FILE"
fi

