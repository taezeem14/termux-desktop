#!/usr/bin/env bash
# start-desktop.sh - Start Taezeem Desktop session (X11 or VNC)
set -e
echo "🚀 Starting Termux Desktop..."

# Kill previous session
pkill xfce4-session 2>/dev/null || true
pkill picom 2>/dev/null || true

# Start pulseaudio
if ! pgrep -x pulseaudio >/dev/null 2>&1; then
  pulseaudio --start || true
fi

# X11 mode
if command -v termux-x11 >/dev/null 2>&1; then
  echo "Using Termux-X11 (native)"
  DISPLAY_VAR=":0"
  nohup termux-x11-nightly -xstartup startxfce4 >/dev/null 2>&1 &
  sleep 2
  echo "Termux-X11 started. Connect via the Termux X11 app."
  exit 0
fi

# VNC fallback
if command -v vncserver >/dev/null 2>&1; then
  GEOMETRY="${1:-1280x720}"
  echo "Starting VNC server..."
  vncserver -geometry "${GEOMETRY}" :1
  echo "Connect using localhost:5901"
  exit 0
fi

echo "❌ No X server found! Install termux-x11 or tigervnc."
exit 1
