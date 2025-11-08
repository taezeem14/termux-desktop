#!/usr/bin/env bash
# set-theme.sh THEME_NAME
THEME="${1:-sample-theme}"
REPO_ROOT="${PWD}"
THEME_DIR="${REPO_ROOT}/themes/${THEME}"

if [ ! -d "$THEME_DIR" ]; then
  echo "Theme not found: $THEME"
  exit 1
fi

mkdir -p "${HOME}/.local/share/themes/${THEME}"
cp -r "$THEME_DIR"/* "${HOME}/.local/share/themes/${THEME}/"

# Apply GTK + Icon + Wallpaper (if XFCE)
if command -v xfconf-query >/dev/null 2>&1; then
  xfconf-query -c xsettings -p /Net/ThemeName -s "$THEME" || true
  xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark" || true
  if [ -f "${HOME}/.local/share/themes/${THEME}/wallpaper.jpg" ]; then
    xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/image-path -s "${HOME}/.local/share/themes/${THEME}/wallpaper.jpg"
  fi
fi

echo "Theme ${THEME} installed and applied!"
