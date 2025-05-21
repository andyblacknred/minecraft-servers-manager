#!/bin/bash

# STEP 1 – resolve project root from current script (4 levels up)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(realpath "$SCRIPT_DIR/../../../..")"
export BASE_DIR
echo "[INFO] BASE_DIR set to $BASE_DIR"

# STEP 2 – path to config.ini
CFG_ORIG="$BASE_DIR/src/config/config.ini"
echo "[START] Loading variables from $CFG_ORIG"

# STEP 3 – verify config file exists
if [[ ! -f "$CFG_ORIG" ]]; then
  echo "[ERROR] config.ini not found at $CFG_ORIG"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 1 2>/dev/null || exit 1
fi

# STEP 4 – check and clean line endings (Windows-style \r)
if grep -q $'\r' "$CFG_ORIG"; then
  echo "[FIX] Detected CRLF line endings in config.ini — cleaning..."
  CFG_CLEAN=$(mktemp)
  tr -d '\r' < "$CFG_ORIG" > "$CFG_CLEAN"
else
  CFG_CLEAN="$CFG_ORIG"
fi

# STEP 5 – export KEY=VALUE lines
while IFS='=' read -r key value; do
  [[ "$key" =~ ^\s*# ]] && continue  # skip comments
  [[ -z "$key" ]] && continue        # skip empty lines
  export "$key"="$value"
done < "$CFG_CLEAN"

# STEP 6 – cleanup
[[ "$CFG_CLEAN" != "$CFG_ORIG" ]] && rm -f "$CFG_CLEAN"

# STEP 7 – done
echo "[DONE] Environment variables loaded."
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
