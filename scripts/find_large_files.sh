#!/bin/bash
echo "🔎 Scanning for files over 100MB in $(pwd)..."
find . -type f -size +100M -exec du -h {} \; | sort -hr

