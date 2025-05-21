#!/bin/bash

echo "[START] Copying server.jar to build folder..."

# STEP 1 – compose source and destination paths
JAR_CACHE="$BASE_DIR/cache/versions/$VERSION.jar"
BUILD_DIR="$BASE_DIR/build/$WORLD_NAME"
JAR_BUILD="$BUILD_DIR/server.jar"

# STEP 2 – debug dump (only if DEBUG=true)
if [[ "$DEBUG" == "true" ]]; then
  echo "[DEBUG] BASE_DIR   = $BASE_DIR"
  echo "[DEBUG] VERSION    = $VERSION"
  echo "[DEBUG] WORLD_NAME = $WORLD_NAME"
  echo "[DEBUG] JAR_CACHE  = $JAR_CACHE"
  echo "[DEBUG] BUILD_DIR  = $BUILD_DIR"
  echo "[DEBUG] JAR_BUILD  = $JAR_BUILD"
fi

# STEP 3 – verify cached JAR exists
if [[ ! -f "$JAR_CACHE" ]]; then
  echo "[ERROR] Cached server.jar not found: $JAR_CACHE"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 1 2>/dev/null || exit 1
fi

# STEP 4 – ensure build folder exists
if [[ ! -d "$BUILD_DIR" ]]; then
  echo "[CREATE] Making build folder: $BUILD_DIR"
  mkdir -p "$BUILD_DIR"
else
  echo "[SKIP] Build folder already exists: $BUILD_DIR"
fi

# STEP 5 – copy JAR into build
echo "[COPY] $JAR_CACHE → $JAR_BUILD"
cp "$JAR_CACHE" "$JAR_BUILD"
if [[ $? -ne 0 ]]; then
  echo "[ERROR] Failed to copy server.jar to build folder."
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 1 2>/dev/null || exit 1
fi

# STEP 6 – confirm success
echo "[DONE] server.jar is ready at: $JAR_BUILD"

# STEP 7 – optional debug pause
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
