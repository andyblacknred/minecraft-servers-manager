#!/bin/bash

echo "[START] Manual backup trigger..."

# STEP 1 – load environment and show variables
source "$(dirname "$0")/helpers/load-env.sh"
source "$(dirname "$0")/helpers/show-env.sh"

# STEP 2 – run backup
"$BASE_DIR/src/scripts/ubuntu/helpers/create-backup.sh"

echo "[DONE] Backup created."
read -p "Press enter to continue..."

exit 0
