# Aliases
# Git
alias g="git"

# docker
alias dc="docker"

# docker compose
alias dcc="docker compose"

# PostgreSQL (for Homebrew)
alias psqlstart='brew services start postgresql'
alias psqlstop='brew services stop postgresql'


## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && source "$HOME/.dart-cli-completion/zsh-config.zsh"
## [/Completion]

# プロンプト設定（ユーザー名、カレントディレクトリ、Git ブランチ）
setopt prompt_subst

precmd () {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    BRANCH_NAME=$(git branch --show-current 2>/dev/null)
    
    # 追加・削除数を取得
    GIT_DIFF=$(git diff --numstat 2>/dev/null)

    ADDED=0
    REMOVED=0

    if [[ -n "$GIT_DIFF" ]]; then
      while read -r add del _; do
        [[ "$add" != "-" ]] && ((ADDED+=add))
        [[ "$del" != "-" ]] && ((REMOVED+=del))
      done <<< "$GIT_DIFF"
    fi

    ADDED_STR=""
    REMOVED_STR=""

    [[ $ADDED -gt 0 ]] && ADDED_STR="%F{green}+${ADDED}%f"
    [[ $REMOVED -gt 0 ]] && REMOVED_STR="%F{red}-${REMOVED}%f"

    GIT_DISPLAY="(${BRANCH_NAME}${ADDED_STR}${REMOVED_STR})"
  else
    GIT_DISPLAY=""
  fi
}

# プロンプト設定
PROMPT='%F{cyan}%n@%m%f %F{green}%~%f ${GIT_DISPLAY} %# '
