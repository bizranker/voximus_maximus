#!/bin/bash

FILE="$1"
FILENAME=$(basename "$FILE")
BASENAME="${FILENAME%.zip}"
TARGET_DIR="/var/www/html/voximus/memory/${BASENAME}"
LOG_FILE="/var/www/html/voximus/logs/dropwatch.log"

echo "📦 $(date) Unpacking $FILENAME to $TARGET_DIR" | tee -a "$LOG_FILE"

mkdir -p "$TARGET_DIR"

# Run unzip *without silencing errors*
unzip -o "$FILE" -d "$TARGET_DIR" >/dev/null 2>&1
EXIT_CODE=$?

if [[ $EXIT_CODE -eq 0 ]]; then
    echo "✅ $(date) Successfully extracted $FILENAME" | tee -a "$LOG_FILE"
else
    echo "❌ $(date) Failed to extract $FILENAME with code $EXIT_CODE" | tee -a "$LOG_FILE"
    file "$FILE" | tee -a "$LOG_FILE"
    ls -l "$FILE" | tee -a "$LOG_FILE"
fi

