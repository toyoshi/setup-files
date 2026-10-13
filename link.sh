#!/bin/zsh
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for dotfile in .Brewfile .gitconfig .vimrc .zprofile .zshrc; do
    ln -fnsv "${SCRIPT_DIR}/${dotfile}" "$HOME/${dotfile}"
done

# アプリの設定ファイル
link() {
    mkdir -p "$(dirname "$2")"
    ln -fnsv "${SCRIPT_DIR}/$1" "$2"
}
link config/ghostty/config.ghostty "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
link config/git/ignore "$HOME/.config/git/ignore"
link config/mise/config.toml "$HOME/.config/mise/config.toml"
