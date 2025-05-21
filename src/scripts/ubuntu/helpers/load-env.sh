#!/bin/bash

# STEP 1 – resolve project root from current script (4 levels up)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(realpath "$SCRIPT_DIR/../../../..")"
export BASE_DIR
echo "[INFO] BASE_DIR set to $BASE_DIR"

# STEP 2 – path to config.ini
CFG="$BASE_DIR/src/config/config.ini"
echo "[START] Loading variables from $CFG"

# STEP 3 – verify config file exists
if [[ ! -f "$CFG" ]]; then
  echo "[ERROR] config.ini not found at $CFG"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 1 2>/dev/null || exit 1
fi

# STEP 4 – export KEY=VALUE lines
while IFS='=' read -r key value; do
  [[ "$key" =~ ^\s*# ]] && continue  # skip comments
  [[ -z "$key" ]] && continue        # skip empty lines
  export "$key"="$value"
done < "$CFG"

# STEP 5 – finish
echo "[DONE] Environment variables loaded."
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
