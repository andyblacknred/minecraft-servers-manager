#!/bin/bash

echo "[START] Detecting server addresses..."

# STEP 1 – detect first non-Radmin (non-169.x, non-26.x) local IPv4
LOCAL_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -vE '^169\.|^26\.' | head -n 1)

# STEP 2 – detect first Radmin VPN (26.x.x.x) address
RADMIN_IP=$(ip -4 addr show | grep -oP '(?<=inet\s)26\.\d+\.\d+\.\d+' | head -n 1)

# STEP 3 – output
echo
echo "=================================================="
echo "  Minecraft Server is starting"
echo
echo "  Local IP:    ${LOCAL_IP:-Not found}:$PORT"
if [[ -n "$RADMIN_IP" ]]; then
  echo "  Radmin VPN:  $RADMIN_IP:$PORT"
else
  echo "  Radmin VPN:  Not found"
fi
echo "=================================================="
echo

# STEP 4 – optional debug pause
[[ "$DEBUG" == "true" ]] && read -p "Press enter to continue..."
