#!/usr/bin/env bash
# install.sh - Termux Desktop Advanced installer
# autodetects: Termux native X11 (termux-x11) vs proot-distro (ubuntu/arch)
# Provides profiles: minimal / full / riced
set -e

# colors
G='\033[1;32m'; Y='\033[1;33m'; R='\033[1;31m'; N='\033[0m'

echo -e "${G}Termux Desktop Advanced - Installer${N}"
PROFILE="${1:-riced}"   # default profile: riced
DE="${2:-xfce}"         # default DE: xfce (openbox|xfce|lxqt)
echo -e "${Y}Profile:${N} $PROFILE   ${Y}DE:${N} $DE"

# helper
run_cmd(){ echo -e "${G}+${N} $*"; eval "$*"; }

# check for proot-distro
if command -v proot-distro >/dev/null 2>&1; then
  MODE="proot"
elif command -v termux-x11 >/dev/null 2>&1 || pkg list-installed | grep -q termux-x11; then
  MODE="native"
else
  MODE="termux"  # fallback to basic termux (will try installing x11-repo)
fi

echo -e "${G}Detected mode:${N} $MODE"

# update base packages
if [ "$MODE" = "proot" ] ; then
  echo -e "${Y}You're in proot-distro. Please run this script inside distro after installing it.${N}"
  echo -e "${Y}If you want to install distro from termux, run:${N}"
  echo "  pkg install proot-distro -y && proot-distro install ubuntu && proot-distro login ubuntu"
  echo -e "${G}Now installing packages inside distro...${N}"
  PKG_INSTALL="apt update && apt install -y"
  INSTALL_NEEDED="xfce4 xfce4-goodies tigervnc pulseaudio pulseaudio-utils rofi picom git wget unzip curl"
else
  echo -e "${G}Running inside Termux (native). Will use pkg and x11-repo if needed.${N}"
  run_cmd "pkg update -y && pkg upgrade -y"
  run_cmd "pkg install x11-repo -y || true"
  PKG_INSTALL="pkg install -y"
  INSTALL_NEEDED="termux-x11-nightly tigervnc xfce4 pulseaudio pulseaudio-utils rofi picom git wget unzip curl"
fi

# install packages
echo -e "${G}Installing packages...${N}"
run_cmd $PKG_INSTALL $INSTALL_NEEDED

# create config dir
REPO_DIR="${PWD}"
CONF_DIR="${HOME}/.termux-desktop-advanced"
mkdir -p "$CONF_DIR"
echo "$REPO_DIR" > "$CONF_DIR/.repo_root"

# copy dotfiles
echo -e "${G}Installing dotfiles...${N}"
mkdir -p "${HOME}/.config/rofi" "${HOME}/.config/picom" "${HOME}/.config/polybar" "${HOME}/.config/xfce4"
cp -r "${REPO_DIR}/dotfiles/rofi/config.rasi" "${HOME}/.config/rofi/config.rasi" 2>/dev/null || true
cp -r "${REPO_DIR}/dotfiles/picom/picom.conf" "${HOME}/.config/picom/picom.conf" 2>/dev/null || true
cp -r "${REPO_DIR}/dotfiles/polybar/config" "${HOME}/.config/polybar/config" 2>/dev/null || true

# create start script if not present
cp "${REPO_DIR}/start-desktop.sh" "${HOME}/.termux-desktop-start" 2>/dev/null || true
chmod +x "${HOME}/.termux-desktop-start"

# enable pulseaudio
echo -e "${G}Configuring PulseAudio...${N}"
if ! pgrep -x pulseaudio >/dev/null 2>&1 ; then
  pulseaudio --start || true
fi

# profiles
echo -e "${G}Applying profile:${N} $PROFILE"
if [ "$PROFILE" = "minimal" ]; then
  echo -e "${Y}Minimal -> core packages only${N}"
elif [ "$PROFILE" = "full" ]; then
  echo -e "${Y}Full -> extra utils (neofetch, htop, thunar)${N}"
  run_cmd $PKG_INSTALL neofetch htop thunar
else
  echo -e "${Y}Riced -> install fonts, themes${N}"
  run_cmd $PKG_INSTALL ttf-dejavu || true
fi

# finish
echo -e "${G}Installed. Use:${N} bash ${HOME}/.termux-desktop-start to start the graphical session."
echo -e "${G}Also check README.md for tips and VNC usage.${N}"
