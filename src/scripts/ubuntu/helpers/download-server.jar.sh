#!/bin/bash

echo "[START] Checking server.jar cache..."

# STEP 1 – define path to cached JAR
JAR_CACHE="$BASE_DIR/cache/versions/$VERSION.jar"

# STEP 2 – skip if already cached
if [[ -f "$JAR_CACHE" ]]; then
  echo "[CACHE] Found server.jar - $JAR_CACHE"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  exit 0
fi

# STEP 3 – create cache folder if needed
mkdir -p "$(dirname "$JAR_CACHE")"

# STEP 4 – fetch metadata and download JAR
echo "[DOWNLOAD] $VERSION not found in cache - downloading..."

URL=$(curl -s https://piston-meta.mojang.com/mc/game/version_manifest.json |
  jq -r --arg VERSION "$VERSION" '.versions[] | select(.id == $VERSION) | .url')

if [[ -z "$URL" ]]; then
  echo "[ERROR] Version $VERSION not found in manifest"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  exit 1
fi

DL_URL=$(curl -s "$URL" | jq -r '.downloads.server.url')
if [[ -z "$DL_URL" ]]; then
  echo "[ERROR] Failed to retrieve download URL from metadata"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  exit 1
fi

echo "[INFO] Download URL - $DL_URL"
curl -L -o "$JAR_CACHE" "$DL_URL"

# STEP 5 – verify download success
if [[ ! -f "$JAR_CACHE" ]]; then
  echo "[ERROR] Download failed for $VERSION"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  exit 1
fi

# STEP 6 – print size and check magic bytes
echo "[INFO] Cached JAR size: $(stat -c '%n = %s bytes' "$JAR_CACHE")"

echo -n "[INFO] Checking magic bytes: "
hexdump -n 2 -e '2/1 "%02X"' "$JAR_CACHE"
echo

# STEP 7 – optional debug pause
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."

exit 0
