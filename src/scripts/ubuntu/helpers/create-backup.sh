#!/bin/bash

echo "[START] Creating backup..."

# STEP 1 – compose paths and timestamp
SOURCE="$BASE_DIR/build/$WORLD_NAME"
VERSION_PATH="$BASE_DIR/backup/$WORLD_NAME/$VERSION"
DEST="$VERSION_PATH/snapshots"

# Date formatting YYYY-MM-DD_HH-MM
DATETIME="$(date '+%Y-%m-%d_%H-%M')"
TARGET="$DEST/$DATETIME"

# STEP 2 – create target folder
mkdir -p "$TARGET"

# STEP 3 – copy world folder and key configs
cp -r "$SOURCE/$WORLD_NAME" "$TARGET/$WORLD_NAME"
cp "$SOURCE/server.properties" "$TARGET/" 2>/dev/null || true
cp "$SOURCE/ops.json" "$TARGET/" 2>/dev/null || true
cp "$SOURCE/whitelist.json" "$TARGET/" 2>/dev/null || true

# STEP 4 – finish message
echo "[DONE] Backup saved in - $TARGET"

# STEP 5 – optional debug pause
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
