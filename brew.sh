#!/bin/zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
brew bundle --file="${SCRIPT_DIR}/.Brewfile" "$@"

# mise で言語をインストール（~/.config/mise/config.toml）
mise install --cd "$SCRIPT_DIR"

# Python 製 CLI
uv tool install osxphotos
