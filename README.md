# setup-files

新しい Mac のセットアップ用 dotfiles / Brewfile / macOS 設定。

## 手順

```bash
xcode-select --install
git clone https://github.com/toyoshi/setup-files.git ~/dotfiles
cd ~/dotfiles
./init.sh   # Homebrew をインストール
./link.sh   # dotfiles とアプリ設定（Ghostty, git ignore）を symlink
./brew.sh   # brew bundle --global
./macos.sh  # Dock / Finder / トラックパッド / 時計 / ⌘英かな の設定
```

- `mas` のアプリは事前に App Store へサインインしておく
- ⌘英かな は Homebrew 版が古く無効化されているため、[dominion525/cmd-eikana](https://github.com/dominion525/cmd-eikana/releases) から手動で入れる（`macos.sh` より前に）
- `~/.env`（APIキー等）、`~/.ssh` はリポジトリに含めない。手動で移す
