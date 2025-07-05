#!/bin/sh
# entrypoint.sh - Startup script for the mxlrc container

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Read configuration from environment variables ---
# Default values are used if the variables are not set.
MUSIC_DIR_INTERNAL=${MUSIC_DIR:-/music}
SLEEP_TIME_INTERNAL=${SLEEP_TIME:-15}
UPDATE_FLAG=""

# Check if the Musixmatch token is set. If not, exit.
if [ -z "$MX_TOKEN" ]; then
    echo "Error: The environment variable MX_TOKEN is not set."
    exit 1
fi

# If UPDATE_FILES is set to "true", add the --update flag.
if [ "$UPDATE_FILES" = "true" ]; then
    UPDATE_FLAG="--update"
fi

echo "Starting the download of the lyrics..."
echo "Target directory (in container): $MUSIC_DIR_INTERNAL"
echo "Sleep time between requests: ${SLEEP_TIME_INTERNAL}s"

# Execute the actual Python script with all parameters.
# 'exec' replaces the current process, which is a best practice in Docker.
exec python mxlrc.py \
    --token "$MX_TOKEN" \
    -s "$MUSIC_DIR_INTERNAL" \
    --sleep "$SLEEP_TIME_INTERNAL" \
    $UPDATE_FLAG
