#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG_SRC="${ROOT_DIR}/iso/airootfs/etc/calamares"
TEST_DIR="$(mktemp -d /tmp/calypso-calamares-test.XXXXXX)"

cleanup() {
  rm -rf -- "${TEST_DIR}"
}
trap cleanup EXIT

command -v calamares >/dev/null 2>&1 || {
  echo "Calamares is not installed on the host." >&2
  exit 1
}

test -f "${CONFIG_SRC}/settings.conf"
test -f "${CONFIG_SRC}/branding/calypso/branding.desc"
test -f "${CONFIG_SRC}/branding/calypso/show.qml"

grep -q '^branding: calypso' "${CONFIG_SRC}/settings.conf"
grep -q '^slideshow: "show.qml"' "${CONFIG_SRC}/branding/calypso/branding.desc"

cp -a "${CONFIG_SRC}/." "${TEST_DIR}/"

echo "==> Calypso Calamares configuration checks passed."
echo "==> Temporary config: ${TEST_DIR}"
echo
echo "Launching Calamares in debug mode with the repository configuration."
echo "Do not continue into disk operations on the host; use a VM for a full installation test."
echo

sudo calamares --debug --config "${TEST_DIR}"
