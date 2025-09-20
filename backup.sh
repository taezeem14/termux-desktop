#!/usr/bin/env bash
# backup.sh - commit .config and dotfiles to a local git repo
DEST="${1:-$HOME/.termux-desktop-backup}"
mkdir -p "$DEST"
cp -r "${HOME}/.config" "$DEST/.config"
cp -r "${HOME}/.local" "$DEST/.local" || true
cd "$DEST"
if [ ! -d .git ]; then
  git init
  git add .
  git commit -m "initial backup"
  echo "Created backup repo at $DEST. Add remote and push: git remote add origin <url> && git push -u origin main"
else
  git add .
  git commit -m "backup $(date -Iseconds)" || true
fi
echo "Backup completed."
