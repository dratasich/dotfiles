#!/bin/sh
# Bootstrap a fresh PC: install git+ansible, run playbook from this clone.
# Usage: git clone <repo> && ./bootstrap.sh [personal|work]
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. git + ansible (chicken-egg: needed to provision)
if command -v pacman >/dev/null 2>&1; then
  sudo pacman -S --needed --noconfirm git ansible
elif command -v apt-get >/dev/null 2>&1; then
  sudo apt-get update
  sudo apt-get install -y git ansible
else
  echo "No pacman/apt-get found — install git and ansible manually." >&2
  exit 1
fi

# 2. provision (packages, shell, syncthing unit, chezmoi init --apply)
PROFILE="${1:-personal}"
ansible-playbook "$REPO_DIR/provision/site.yml" \
  --ask-become-pass --extra-vars "profile=$PROFILE"

echo "Done. Start Syncthing and wait for ~/Sync (KeePass, SSH keys)."
