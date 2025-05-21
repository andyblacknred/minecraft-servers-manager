#!/bin/bash

echo "[START] Starting server bootstrap..."

# STEP 1: Load BASE_DIR and environment variables
source "$(dirname "$0")/helpers/load-env.sh"
source "$(dirname "$0")/helpers/show-env.sh"

# STEP 2: Prepare build folder and server files
source "$BASE_DIR/src/scripts/ubuntu/helpers/ensure-build-folder.sh"
source "$BASE_DIR/src/scripts/ubuntu/helpers/download-server.jar.sh"
source "$BASE_DIR/src/scripts/ubuntu/helpers/copy-server.jar-to-build.sh"
source "$BASE_DIR/src/scripts/ubuntu/helpers/generate-eula.sh"
source "$BASE_DIR/src/scripts/ubuntu/helpers/generate-server.properties.sh"

# STEP 3: (optional) Backup before launch
source "$BASE_DIR/src/scripts/ubuntu/helpers/create-backup.sh"

# STEP 4: Show IPs
source "$BASE_DIR/src/scripts/ubuntu/helpers/print-server-address.sh"

# STEP 5: Launch server
cd "$BASE_DIR/build/$WORLD_NAME" || {
  echo "[ERROR] Failed to change directory to build/$WORLD_NAME"
  exit 1
}

echo "Running from: $(pwd)"
java -Xms"$XMS" -Xmx"$XMX" -jar server.jar

echo "[DONE] Server process exited."
read -p "Press enter to continue..."

exit 0
