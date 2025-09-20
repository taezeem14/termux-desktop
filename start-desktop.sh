#!/usr/bin/env bash
# start-desktop.sh - Start Termux Desktop session (X11 or VNC)
set -e
echo "Starting Termux Desktop..."

# pulseaudio
if ! pgrep -x pulseaudio >/dev/null 2>&1; then
  pulseaudio --start || true
fi

# if termux-x11 exists, use it (native)
if command -v termux-x11 >/dev/null 2>&1; then
  echo "Using termux-x11 (native X server)"
  # try starting XFCE
  DISPLAY_VAR=":0"
  nohup termux-x11-nightly -xstartup startxfce4 >/dev/null 2>&1 &
  sleep 2
  echo "termux-x11 started. Attach via the Termux X11 app."
  exit 0
fi

# else use VNC
if command -v vncserver >/dev/null 2>&1; then
  GEOMETRY="${1:-1280x720}"
  echo "Starting TigerVNC server at display :1 geometry ${GEOMETRY}"
  vncserver -geometry "${GEOMETRY}" :1
  echo "Set DISPLAY variable: export DISPLAY=:1"
  echo "To connect: use a VNC viewer to connect to localhost:5901 (or use Termux VNC client)"
  exit 0
fi

echo "No X server found. Install termux-x11 or tigervnc. See README."
exit 1
