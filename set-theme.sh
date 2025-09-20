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
# set gtk theme for xfce
xfconf-query -c xsettings -p /Net/ThemeName -s "$THEME" 2>/dev/null || true
echo "Theme ${THEME} installed and applied (if desktop supports it)."
