#!/usr/bin/env bash
# install.sh - Taezeem x Aditya Termux Desktop Optimized Installer
# Detects mode (native/proot), installs only what’s needed, supports profiles & themes

set -e
G='\033[1;32m'; Y='\033[1;33m'; R='\033[1;31m'; N='\033[0m'
echo -e "${G}Taezeem Desktop Advanced Installer${N}"

# Prompt for profile
echo -e "${Y}Select profile:${N}"
echo "1) minimal  2) full  3) riced"
read -p "Choice [1-3]: " opt
case $opt in
  1) PROFILE="minimal" ;;
  2) PROFILE="full" ;;
  3|*) PROFILE="riced" ;;
esac

# Default DE
read -p "Choose desktop environment (xfce/openbox/lxqt) [xfce]: " DE
DE=${DE:-xfce}

echo -e "${Y}Profile:${N} $PROFILE   ${Y}DE:${N} $DE"

# Mode detect
if command -v proot-distro >/dev/null 2>&1; then
  MODE="proot"
elif command -v termux-x11 >/dev/null 2>&1 || pkg list-installed | grep -q termux-x11; then
  MODE="native"
else
  MODE="termux"
fi
echo -e "${G}Detected mode:${N} $MODE"

# Update + install core
if [ "$MODE" = "proot" ]; then
  echo -e "${Y}Run this inside your distro (Ubuntu/Arch) for best results.${N}"
  PKG_INSTALL="apt install -y"
  run_update="apt update -y"
else
  run_update="pkg update -y && pkg upgrade -y"
  run_cmd() { echo -e "${G}+${N} $*"; eval "$*"; }
  run_cmd "$run_update"
  run_cmd "pkg install -y x11-repo termux-api"
  PKG_INSTALL="pkg install -y"
fi

# Install core utils
CORE_PKGS="tigervnc pulseaudio pulseaudio-utils git wget curl unzip xfce4 picom rofi"
run_cmd "$PKG_INSTALL $CORE_PKGS"

# Extras based on profile
case $PROFILE in
  minimal)
    echo -e "${Y}Installing minimal essentials...${N}"
    run_cmd "$PKG_INSTALL xfce4-terminal"
    ;;
  full)
    echo -e "${Y}Installing full desktop tools...${N}"
    run_cmd "$PKG_INSTALL neofetch htop thunar nitrogen"
    ;;
  riced)
    echo -e "${Y}Installing riced extras...${N}"
    run_cmd "$PKG_INSTALL neofetch fonts-dejavu papirus-icon-theme nitrogen"
    ;;
esac

# Create config dirs
REPO_DIR="${PWD}"
CONF_DIR="${HOME}/.termux-desktop-advanced"
mkdir -p "$CONF_DIR"
echo "$REPO_DIR" > "$CONF_DIR/.repo_root"

# Copy dotfiles
echo -e "${G}Installing dotfiles...${N}"
mkdir -p "${HOME}/.config"
cp -r "${REPO_DIR}/dotfiles/"* "${HOME}/.config/" || true

# Copy start script
cp "${REPO_DIR}/start-desktop.sh" "${HOME}/.termux-desktop-start" 2>/dev/null || true
chmod +x "${HOME}/.termux-desktop-start"

# PulseAudio setup
if ! pgrep -x pulseaudio >/dev/null 2>&1 ; then
  pulseaudio --start || true
fi

# Apply default theme
bash "${REPO_DIR}/set-theme.sh" "sample-theme" || true

echo -e "${G}✔ Installation complete!${N}"
echo -e "${Y}Start desktop with:${N} bash ~/.termux-desktop-start"
