#!/bin/bash

echo "[START] Show versions..."

# STEP 1: Load environment and show basic variables
source "$(dirname "$0")/helpers/load-env.sh"
source "$(dirname "$0")/helpers/show-env.sh"

# STEP 2: Call the versions list helper
"$BASE_DIR/src/scripts/ubuntu/helpers/get-versions.sh"

echo "[DONE] End of the versions list."
read -p "Press enter to continue..."

exit 0
