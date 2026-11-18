#!/usr/bin/env bash
# Build & install libfprint with the native Validity/VCSFW driver (MR !626)
# for the Validity Sensors 138a:00ab fingerprint reader.
# Installs into /usr/local (overrides the distro libfprint via ld.so search order,
# without overwriting any dpkg-managed files). Undo: run with --uninstall.
set -euo pipefail

SRC="${SRC:-$HOME/.local/src/validity-fprint}"
mkdir -p "$SRC"
LIB="$SRC/libfprint"
DATA="$SRC/libfprint-validity-data"
BUILD="$LIB/_build"

if [[ "${1:-}" == "--uninstall" ]]; then
  sudo env PYTHONNOUSERSITE=1 ninja -C "$BUILD" uninstall || true
  sudo rm -rf /usr/local/share/libfprint/validity
  sudo ldconfig
  sudo systemctl restart fprintd || true
  echo "Removed. System libfprint is active again."
  exit 0
fi

# Re-clone if the scratchpad was cleared
[[ -d "$LIB" ]]  || git clone --depth 50 -b wip/validity-vcsfw-driver https://gitlab.freedesktop.org/ggiesen/libfprint.git "$LIB"
[[ -d "$DATA" ]] || git clone https://gitlab.freedesktop.org/ggiesen/libfprint-validity-data.git "$DATA"

echo "==> Installing build dependencies"
if command -v apt-get >/dev/null; then
  sudo apt-get update
  sudo apt-get install -y build-essential meson ninja-build pkg-config git python3 \
    libglib2.0-dev libgusb-dev libgudev-1.0-dev libpixman-1-dev libnss3-dev \
    libssl-dev libcairo2-dev libudev-dev udev systemd-dev gobject-introspection libgirepository1.0-dev \
    fprintd libpam-fprintd
elif command -v pacman >/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel meson ninja git python \
    glib2 libgusb libgudev pixman nss openssl cairo systemd gobject-introspection \
    fprintd
else
  echo "Unsupported distro: install meson, ninja, glib2, gusb, gudev, pixman, nss, openssl, cairo, udev/systemd dev files, fprintd manually." >&2
fi

echo "==> Building libfprint (validity driver)"
# Use the system meson for both setup and (root) install, ignoring any
# user-installed meson in ~/.local, so the versions match.
export PYTHONNOUSERSITE=1
MESON=/usr/bin/meson
if [[ -f "$BUILD/build.ninja" ]] && [[ "${REBUILD:-}" != 1 ]] && grep -q "$MESON" "$BUILD/build.ninja"; then
  echo "(reusing existing build directory)"
else
  rm -rf "$BUILD"
  $MESON setup "$BUILD" "$LIB" --prefix=/usr/local -Ddrivers=default -Ddoc=false -Dgtk-examples=false
fi
ninja -C "$BUILD"

echo "==> Installing libfprint into /usr/local"
sudo env PYTHONNOUSERSITE=1 $MESON install -C "$BUILD" --no-rebuild
# Arch doesn't search /usr/local/lib by default; make sure the override wins
if command -v pacman >/dev/null && [[ ! -f /etc/ld.so.conf.d/00-usr-local.conf ]]; then
  echo /usr/local/lib | sudo tee /etc/ld.so.conf.d/00-usr-local.conf >/dev/null
fi
sudo ldconfig

echo "==> Generating & installing the validity runtime data package"
( cd "$DATA" && make generate && sudo make install PREFIX=/usr/local )

echo "==> Restarting fprintd"
sudo systemctl daemon-reload
sudo systemctl restart fprintd || true
sleep 2

echo "==> fprintd is using:"
for f in /usr/libexec/fprintd /usr/lib/fprintd; do [[ -x $f ]] && ldd "$f" | grep libfprint; done || true
echo "==> Devices:"
fprintd-list "$USER" || true

cat <<EOF

Next steps:
  fprintd-enroll            # enroll a finger (swipe/touch ~5-8 times)
  fprintd-verify            # test it
  sudo pam-auth-update      # enable "Fingerprint authentication" for login/sudo
Undo everything:  $0 --uninstall
EOF
