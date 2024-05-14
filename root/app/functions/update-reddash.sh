#!/usr/bin/env sh
set -euf

# Make sure we are in the venv
[ -n "${VIRTUAL_ENV:-}" ]

if [ -n "${CUSTOM_DASHBOARD_PACKAGE:-}" ]; then
    echo "WARNING: You have specified a custom Red-Web-Dashboard Pip install. Little to no support will be given for this setup."
    echo "Updating Red-Web-Dashboard with \"${CUSTOM_DASHBOARD_PACKAGE}\"..."
    python -m pip install --upgrade --upgrade-strategy eager --no-cache-dir wheel "${CUSTOM_DASHBOARD_PACKAGE}"
    echo "${CUSTOM_DASHBOARD_PACKAGE}" >"/data/venv/.reddashversion"
else
    # Update dashboard
    DASHBOARD_PACKAGE_NAME="Red-Web-Dashboard${DASHBOARD_VERSION:-}"
    UPGRADE_STRATEGY=""
    if [ ! -f "/data/venv/.reddashversion" ] || [ "$(cat "/data/venv/.reddashversion")" != "${DASHBOARD_PACKAGE_NAME}" ]; then
        UPGRADE_STRATEGY="--upgrade-strategy eager"
    fi
    echo "Updating ${DASHBOARD_PACKAGE_NAME}..."
    # shellcheck disable=SC2086
    python -m pip install --upgrade ${UPGRADE_STRATEGY} --no-cache-dir wheel "${DASHBOARD_PACKAGE_NAME}"
    echo "${DASHBOARD_PACKAGE_NAME}" >"/data/venv/.reddashversion"
fi
