#!/usr/bin/env bash
set -euo pipefail

# run from the script directory
cd "$(dirname "${BASH_SOURCE[0]}")"

URL="https://raw.githubusercontent.com/obsproject/obs-websocket/refs/heads/master/docs/generated/protocol.json"
OUT="obs-prot.json"

echo "Downloading $URL -> $OUT"
if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$URL" -o "$OUT"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$OUT" "$URL"
else
    echo "error: curl or wget is required" >&2
    exit 2
fi

echo "Downloaded $OUT"

if ! command -v bun >/dev/null 2>&1; then
    echo "error: bun not found in PATH" >&2
    exit 3
fi

echo "Running: bun obs-compiler.js"
bun obs-compiler.js > src/obs-codegen.js