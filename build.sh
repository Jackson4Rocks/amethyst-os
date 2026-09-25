#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROFILE="${ROOT_DIR}/iso"
CALAMARES_DIR="${PROFILE}/packages/calamares"
LOCAL_REPO="/tmp/calypso-calamares-repo"
TEMP_PACMAN_CONF="/tmp/calypso-pacman.conf"
WORK_DIR="${HOME}/calypso-build"
OUT_DIR="${HOME}/calypso-out"

cleanup() {
  rm -rf -- "${LOCAL_REPO}" "${TEMP_PACMAN_CONF}"
}
trap cleanup EXIT

command -v mkarchiso >/dev/null 2>&1 || {
  echo "mkarchiso is not installed. Install archiso first." >&2
  exit 1
}

command -v makepkg >/dev/null 2>&1 || {
  echo "makepkg is not available. This script must run on an Arch Linux build host." >&2
  exit 1
}

command -v repo-add >/dev/null 2>&1 || {
  echo "repo-add is not available." >&2
  exit 1
}

echo "==> Building custom Calamares package..."
(
  cd "${CALAMARES_DIR}"
  rm -f -- calamares-*.pkg.tar.*
  makepkg --syncdeps --noconfirm --cleanbuild --clean
)

CALAMARES_PKG="$(find "${CALAMARES_DIR}" -maxdepth 1 -type f -name 'calamares-*.pkg.tar.*' -print -quit)"
[[ -n "${CALAMARES_PKG}" ]] || {
  echo "Calamares package was not produced." >&2
  exit 1
}

echo "==> Creating temporary Calypso package repository..."
rm -rf -- "${LOCAL_REPO}"
mkdir -p -- "${LOCAL_REPO}"
cp -- "${CALAMARES_PKG}" "${LOCAL_REPO}/"
repo-add "${LOCAL_REPO}/calypso.db.tar.zst" "${LOCAL_REPO}/$(basename "${CALAMARES_PKG}")" >/dev/null

echo "==> Preparing pacman configuration..."
awk '
  /^\[core\]$/ && !added {
    print "[calypso]"
    print "SigLevel = Optional TrustAll"
    print "Server = file:///tmp/calypso-calamares-repo"
    print ""
    added=1
  }
  { print }
' "${PROFILE}/pacman.conf" > "${TEMP_PACMAN_CONF}"

echo "==> Cleaning previous Calypso build..."
sudo rm -rf -- "${WORK_DIR}" "${OUT_DIR}"
mkdir -p -- "${WORK_DIR}" "${OUT_DIR}"

echo "==> Building Calypso Linux..."
sudo mkarchiso -v -r \
  -C "${TEMP_PACMAN_CONF}" \
  -w "${WORK_DIR}" \
  -o "${OUT_DIR}" \
  "${PROFILE}"

echo
echo "==> Calypso ISO build complete."
echo "    Output: ${OUT_DIR}"
ls -lh "${OUT_DIR}"
