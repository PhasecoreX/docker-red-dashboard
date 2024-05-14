#!/usr/bin/env sh
set -euf

# Remove old python venv if detected
PYVERSION=$(realpath "$(command -v python)" | grep -o '[^/]*$')
if [ ! -f "/data/venv/.pyversion" ] || [ "$(cat "/data/venv/.pyversion")" != "${PYVERSION}" ]; then
    rm -rf /data/venv
    mkdir -p /data/venv
    echo "${PYVERSION}" >"/data/venv/.pyversion"
fi

# Prepare and activate venv
echo "Activating Python virtual environment..."
mkdir -p /data/venv
python -m venv --upgrade --upgrade-deps /data/venv
python -m venv /data/venv
. /data/venv/bin/activate
