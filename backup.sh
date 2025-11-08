#!/usr/bin/env bash
# backup.sh - Backup configs & dotfiles with compression
DEST="${1:-$HOME/.termux-desktop-backup}"
DATE=$(date +%Y%m%d-%H%M)
mkdir -p "$DEST"
cp -r "${HOME}/.config" "$DEST/.config"
cp -r "${HOME}/.local" "$DEST/.local" || true

cd "$DEST"
if [ ! -d .git ]; then
  git init
fi
git add .
git commit -m "backup ${DATE}" || true
tar -czf "backup-${DATE}.tar.gz" .config .local
echo "Backup complete: $DEST/backup-${DATE}.tar.gz"
