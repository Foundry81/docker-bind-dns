#!/bin/bash
set -e

# ------------------------
# Paths and variables
# ------------------------
CONFIG_DIR="${CONFIG_DIR:-/bind/etc}"
ZONE_DIR="${CONFIG_DIR}/zones"
CACHE_DIR="/var/cache/bind"
RUNTIME_DIR="/var/run/named"
BIND_USER="${BIND_USER:-bind}"
CONFIG_FILE="${CONFIG_DIR}/named.conf"

# ------------------------
# Initialize host mount if empty
# ------------------------
if [ ! -f "${CONFIG_FILE}" ]; then
    echo "Host config mount is empty, initializing BIND configuration..."

    # Copy default Debian BIND configs from a location not masked by the volume
    # Package installs defaults to /etc/bind.orig inside image
    mkdir -p "${CONFIG_DIR}"
    cp -r /etc/bind/* "${CONFIG_DIR}/"

    # Ensure zones directory exists
    mkdir -p "${ZONE_DIR}"

    # Minimal named.conf.local so BIND can start
    if [ ! -f "${CONFIG_DIR}/named.conf.local" ]; then
        cat > "${CONFIG_DIR}/named.conf.local" <<'EOF'
options {
    directory "/var/cache/bind";
    recursion yes;
    allow-query { any; };
};

zone "." IN {
    type hint;
    file "/usr/share/dns/root.hints";
};
EOF
    fi

    # Permissions
    chown -R root:"${BIND_USER}" "${CONFIG_DIR}"
fi

# ------------------------
# Runtime directories
# ------------------------
mkdir -p "${RUNTIME_DIR}" "${CACHE_DIR}"
chown root:"${BIND_USER}" "${RUNTIME_DIR}" "${CACHE_DIR}"
chmod 775 "${RUNTIME_DIR}" "${CACHE_DIR}"

# ------------------------
# Signal handling
# ------------------------
trap 'echo "Shutting down BIND..."; exit 0' SIGTERM SIGINT

# ------------------------
# Start BIND
# ------------------------
echo "Starting BIND..."
exec named -u "${BIND_USER}" -g -c "${CONFIG_FILE}"
