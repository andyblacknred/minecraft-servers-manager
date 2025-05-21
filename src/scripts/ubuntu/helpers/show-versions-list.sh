#!/bin/bash

echo "[START] Fetching Minecraft version list..."

# STEP 1 – fetch and print version IDs
curl -s https://piston-meta.mojang.com/mc/game/version_manifest.json |
  jq -r '.versions[].id'

# STEP 2 – completion notice
echo "[DONE] Version list fetched."

# STEP 3 – optional debug pause
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."

exit 0
