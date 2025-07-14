#!/bin/bash

set -e
set -o pipefail

# Define paths
VOX_DIR="/var/www/html/voximus"
DROPZONE="${VOX_DIR}/dropzone"
EXPORTS="${VOX_DIR}/exports"
TS=$(date +"%Y%m%d_%H%M%S")

# Find newest ZIP file
NEW_EXPORT=$(find "$DROPZONE" -maxdepth 1 -type f -name '*.zip' | sort | tail -n 1)

if [[ ! -f "$NEW_EXPORT" ]]; then
  echo "❌ No export ZIP file found in dropzone."
  exit 1
fi

echo "📦 Found export: $NEW_EXPORT"

# Extract and move to versioned directory
DEST="${EXPORTS}/export_${TS}"
mkdir -p "$DEST"
unzip -q "$NEW_EXPORT" -d "$DEST"

echo "📂 Extracted to $DEST"

# (Optional) Append to vox-flat.txt
if [[ -f "${DEST}/conversations.json" ]]; then
  echo "🔗 Flattening to vox-flat.txt..."
  jq -r '.[] | .title + ": " + (.mapping[]?.message.content.parts[0] // "")' "${DEST}/conversations.json" >> "${VOX_DIR}/vox-flat.txt"
fi

# Commit changes
cd "$VOX_DIR"
git add .
git commit -m "🪐 Memory drop processed: $(basename "$NEW_EXPORT")"
git push origin main

echo "✅ Voximus update complete."

