#!/bin/zsh

brew bundle --global

# mise で言語をインストール（~/.config/mise/config.toml）
mise install

# Python 製 CLI
uv tool install osxphotos
