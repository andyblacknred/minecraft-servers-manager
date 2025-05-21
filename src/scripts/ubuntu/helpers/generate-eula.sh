#!/bin/bash

echo "[START] Generating eula.txt"

# STEP 1 – define template and output paths
TPL="$BASE_DIR/src/config/eula.template.txt"
OUT="$BASE_DIR/build/$WORLD_NAME/eula.txt"

# STEP 2 – skip if already exists
if [[ -f "$OUT" ]]; then
  echo "[SKIP] eula.txt already exists - $OUT"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 0 2>/dev/null || true
fi

# STEP 3 – check if template exists
if [[ ! -f "$TPL" ]]; then
  echo "[ERROR] Template not found - $TPL"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 1 2>/dev/null || exit 1
fi

# STEP 4 – copy template as base
mkdir -p "$(dirname "$OUT")"
cp "$TPL" "$OUT"
if [[ $? -ne 0 ]]; then
  echo "[ERROR] Failed to copy template to: $OUT"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 1 2>/dev/null || exit 1
fi

# STEP 5 – update 2nd line with current timestamp
# Format example: "#Mon May 20 13:45:00 EEST 2025"
timestamp="#$(LC_TIME=en_US.UTF-8 date '+%a %b %d %T %Z %Y')"

# Use sed to replace the second line
tmpfile="$(mktemp)"
awk -v ts="$timestamp" 'NR==2 {$0=ts} {print}' "$OUT" > "$tmpfile" && mv "$tmpfile" "$OUT"

echo "[DONE] eula.txt created - $OUT"

# STEP 6 – optional debug pause
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
