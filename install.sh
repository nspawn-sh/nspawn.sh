#!/bin/sh
set -eu

REPO="https://raw.githubusercontent.com/nspawn-sh/nspawn.sh/main"

if [ -n "${ANDROID_ROOT:-}" ] && [ -n "${ANDROID_DATA:-}" ]; then
    INSTALL_DIR="${PREFIX:-/data/data/com.termux/files/usr}/bin"
else
    INSTALL_DIR="/usr/local/bin"
fi

die() { printf 'Error: %s\n' "$*" >&2; exit 1; }

if command -v curl >/dev/null 2>&1; then
    fetch() { curl -fL "$1" -o "$2"; }
elif command -v wget >/dev/null 2>&1; then
    fetch() { wget -q "$1" -O "$2"; }
else
    die "Need curl or wget"
fi

mkdir -p "$INSTALL_DIR"

for bin in nspawn getroot; do
    fetch "$REPO/$bin" "$INSTALL_DIR/$bin"
    chmod +x "$INSTALL_DIR/$bin"
done

echo "Installed nspawn and getroot to $INSTALL_DIR"
