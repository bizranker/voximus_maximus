#!/bin/bash

# ┌──────────────────────────────────────────────────────────────┐
# │ 🥔 SPUDS PROTOCOL — MENTAL AUTO-PILOT UNDER DISTRESS         │
# └──────────────────────────────────────────────────────────────┘
# Inspired by the 1970s SNL skit featuring Bill Murray:
# “When you’ve got Spuds, you can put your mind on hold, do what you're told…”
#
# This daemon uses inotifywait to monitor new drops in real time.
# Ideal for burnout, loops of despair, and voximus blob imports.

WATCH_DIR="/var/www/html/voximus/blobs"
ACTION_SCRIPT="/var/www/html/voximus/scripts/process_drop.sh"
LOG_FILE="/var/log/dropwatch.log"

echo "🧠 Dropwatch initiated. Watching $WATCH_DIR..." | sudo tee -a "$LOG_FILE"

inotifywait -m -q -e create,moved_to --format "%f" "$WATCH_DIR" | while read -r filename; do
    echo "📥 [$(date)] New memory drop detected: $filename" | sudo tee -a "$LOG_FILE"

    if [[ -x "$ACTION_SCRIPT" ]]; then
        "$ACTION_SCRIPT" "$WATCH_DIR/$filename"
    else
        echo "⚠️ [$(date)] Action script not found or not executable: $ACTION_SCRIPT" | sudo tee -a "$LOG_FILE"
    fi
done

