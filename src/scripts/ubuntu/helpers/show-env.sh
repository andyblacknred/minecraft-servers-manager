#!/bin/bash

echo "[START] Printing environment variables"

echo "==================  ACTIVE ENV  =================="
echo "BASE_DIR      = $BASE_DIR"
echo "WORLD_NAME    = $WORLD_NAME"
echo "MOTD          = $MOTD"
echo "DEBUG         = $DEBUG"
echo "VERSION       = $VERSION"
echo "PORT          = $PORT"
echo "XMS           = $XMS"
echo "XMX           = $XMX"
echo "=================================================="

# Optional full dump if DEBUG=true
if [[ "$DEBUG" == "true" ]]; then
  echo "------------------  FULL DUMP  ------------------"
  env
  echo "--------------------------------------------------"
fi

echo "[END] Environment variables printed."

[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."

exit 0
