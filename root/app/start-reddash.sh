#!/usr/bin/env sh
set -euf

# Perform mount check
/app/functions/check-mount.sh

# Setup environment
. /app/functions/setup-env.sh

# Update reddash if needed
/app/functions/update-reddash.sh

# Start dashboard
echo "Starting Red-Dashboard!"
# shellcheck disable=SC2086
reddash ${EXTRA_ARGS:-}
