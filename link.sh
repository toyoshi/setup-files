#!/bin/zsh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

for dotfile in ${SCRIPT_DIR}/.??* ; do
    [[ "$dotfile" == "${SCRIPT_DIR}/.git" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.github" ]] && continue
    [[ "$dotfile" == "${SCRIPT_DIR}/.DS_Store" ]] && continue

    ln -fnsv "$dotfile" "$HOME"
done

# アプリの設定ファイル
link() {
    mkdir -p "$(dirname "$2")"
    ln -fnsv "${SCRIPT_DIR}/$1" "$2"
}
link config/ghostty/config.ghostty "$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
link config/git/ignore "$HOME/.config/git/ignore"
link config/mise/config.toml "$HOME/.config/mise/config.toml"
