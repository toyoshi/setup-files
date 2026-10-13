# setup-files

Apple Silicon Mac のセットアップ用 dotfiles / Brewfile / macOS 設定。2026-10-13の実機のインストール内容・設定と照合済み。

## 手順

```bash
xcode-select --install
git clone https://github.com/toyoshi/setup-files.git ~/dotfiles
cd ~/dotfiles
./init.sh   # Homebrew をインストール
./link.sh   # dotfiles とアプリ設定（Ghostty, git ignore, mise）を symlink
./brew.sh   # このリポジトリのBrewfileからインストール・更新、Rubyとosxphotosも導入
./macos.sh  # Dock / Finder / トラックパッド / 時計 / ⌘英かな の設定
./folder-actions.sh  # デスクトップの画像縮小フォルダとAutomatorのフォルダアクション
```

- `mas` のアプリは事前に App Store へサインインしておく
- ChromeはBrewfileの `cask "google-chrome"` でインストールする
- ⌘英かなは `dominion525/tap/cmd-eikana` でインストールする。初回起動時に「システム設定 > プライバシーとセキュリティ」でアクセシビリティと入力監視を許可する
- `~/.env`（APIキー等）、`~/.zshrc.local`（IP等の非公開設定）、`~/.ssh` はリポジトリに含めない。手動で移す

## 既存のMacでアプリを更新

```bash
./brew.sh
```

HomebrewのアプリとCLIをインストール・更新する。既存のHomebrewパッケージを更新せず、不足分だけ入れる場合は `./brew.sh --no-upgrade` を使う。

## 画像縮小・JPEG変換フォルダ

`./folder-actions.sh` は `~/Desktop/画像縮小` を作成し、`config/automator/画像縮小・JPEG化.workflow` をユーザーのLibraryにコピーしてフォルダアクションを登録する。新しい画像を入れると、現在のMacと同じ順序で1024pxへのサイズ調整とJPEG変換を行う。元の画像をその場で変更するので、原本を残す場合はコピーを入れる。

再実行時は同じワークフローを重複登録しない。既存のワークフローに差分がある場合は `.backup.日時` の名前で保存してから更新する。初回実行時にmacOSからSystem Eventsの操作やデスクトップへのアクセスを求められたら許可する。登録済みのフォルダアクションはFinderのフォルダのコンテキストメニューから確認できる。

フォルダアクションの仕組みは[Appleの説明](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/WatchFolders.html)を参照。
