#!/usr/bin/env bash
set -euo pipefail

current_user="$(id -un)"

if [ "$current_user" = "root" ]; then
  apt update
  apt install -y sudo curl ca-certificates python3 git ansible
  ansible-playbook create-user.yml
  chown -R joey:joey /opt/ansible-dotfiles
elif [ "$current_user" = "joey" ]; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
  source "$HOME/.local/bin/env"
  uv sync
  uv run ansible-playbook dotfiles-linux.yml
else
  echo "Run this as root for user bootstrap, or as joey for dotfiles bootstrap." >&2
  exit 1
fi
