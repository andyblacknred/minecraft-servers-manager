#!/bin/bash

# STEP 1 – ensure build/<WORLD_NAME> directory exists
BUILD_DIR="$BASE_DIR/build/$WORLD_NAME"

if [[ ! -d "$BUILD_DIR" ]]; then
  echo "[CREATE] Creating build folder: $BUILD_DIR"
  mkdir -p "$BUILD_DIR"
else
  echo "[SKIP] Build folder already exists: $BUILD_DIR"
fi

# STEP 2 – optional pause when DEBUG=true
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
