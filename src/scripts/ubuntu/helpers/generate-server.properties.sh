#!/bin/bash

echo "[START] Generating server.properties from template"

# STEP 1 – define paths
TEMPLATE="$BASE_DIR/src/config/server.template.properties"
OUTPUT="$BASE_DIR/build/$WORLD_NAME/server.properties"

# STEP 2 – verify template exists
if [[ ! -f "$TEMPLATE" ]]; then
  echo "[ERROR] Template not found - $TEMPLATE"
  [[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
  return 1 2>/dev/null || exit 1
fi

# STEP 3 – ensure output folder exists
mkdir -p "$(dirname "$OUTPUT")"

# STEP 4 – perform replacements and write to output
sed -e "s|@WORLD_NAME@|$WORLD_NAME|g" \
    -e "s|@PORT@|$PORT|g" \
    -e "s|@MOTD@|$MOTD|g" \
    "$TEMPLATE" > "$OUTPUT"

# STEP 5 – finish message
echo "[DONE] server.properties created - $OUTPUT"

# STEP 6 – optional debug pause
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
