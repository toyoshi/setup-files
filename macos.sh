#!/bin/zsh
# macOS の設定（今の Mac で変更していたもの）

# Dock: 自動的に隠す / アイコンサイズ / 右下ホットコーナー = クイックメモ
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock tilesize -int 64
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0

# Finder: リスト表示 / ステータスバー表示 / 外部ディスクをデスクトップに表示 / 30日経ったゴミ箱を削除
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# トラックパッド: タップでクリック / 軌跡の速さ最大
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.trackpad.scaling -float 3

# メニューバーの時計: 曜日と午前/午後を表示
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowAMPM -bool true

# ⌘英かな（dominion525 fork）のキー設定: 左右⌘で英数/かな、; と : を入れ替え
defaults import io.github.dominion525.cmd-eikana "$(cd "$(dirname "$0")" && pwd)/config/cmd-eikana/settings.plist"

killall Dock Finder SystemUIServer 2>/dev/null
echo "一部の設定（トラックパッド等）はログアウト後に反映されます"
