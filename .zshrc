# 補完機能
autoload -U compinit
compinit

# コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ディレクトリ名を入力するだけで移動
setopt auto_cd

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# コマンド訂正
setopt correct

# 補完候補を詰めて表示する
setopt list_packed

# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# 環境変数読み込み
[ -f ~/.env ] && source ~/.env

alias claude-local='ANTHROPIC_AUTH_TOKEN=ollama ANTHROPIC_BASE_URL=http://<LOCAL_LLM_HOST>:11434 claude --model qwen3.6:256k'

# <VPN_NAME>接続 + SSH + claude起動
chita() {
  local VPN_NAME="<VPN_NAME>"

  if ! scutil --nc status "$VPN_NAME" | grep -q "^Connected$"; then
    echo "VPN接続中..."
    scutil --nc start "$VPN_NAME"
    local i=0
    until scutil --nc status "$VPN_NAME" | grep -q "^Connected$"; do
      sleep 1
      ((i++))
      if [ $i -gt 20 ]; then
        echo "VPN接続失敗"
        return 1
      fi
    done
    echo "VPN接続完了"
  fi

  ssh chita
}

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"
