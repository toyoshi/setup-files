# setup-files

新しい Mac のセットアップ用 dotfiles / Brewfile。

## 手順

```bash
xcode-select --install
git clone https://github.com/toyoshi/setup-files.git ~/dotfiles
cd ~/dotfiles
./init.sh   # Homebrew をインストール
./link.sh   # dotfiles を $HOME にシンボリックリンク（.Brewfile 含む）
./brew.sh   # brew bundle --global
```

- `mas` のアプリは事前に App Store へサインインしておく
- `~/.env`（APIキー等）はリポジトリに含めない。`.zshrc` から存在すれば読み込む
