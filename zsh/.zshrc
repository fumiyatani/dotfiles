# Load oh my zsh 
[[ -f "$HOME/.zsh/omz.zsh" ]] && source "$HOME/.zsh/omz.zsh"

# Load brew-managed zsh plugins
[[ -f "$HOME/.zsh/brew-plugins.zsh" ]] && source "$HOME/.zsh/brew-plugins.zsh"

# Load user-defined aliases
[[ -f "$HOME/.zsh/user-aliases.zsh" ]] && source "$HOME/.zsh/user-aliases.zsh"

# Load user key bindings
[[ -f "$HOME/.zsh/user-key-bind.zsh" ]] && source "$HOME/.zsh/user-key-bind.zsh"

################################
# Completion
################################
# Dart CLI
[[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && \
  source "$HOME/.dart-cli-completion/zsh-config.zsh" || true

################################
# Prompt
################################
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
    [[ $ADDED   -gt 0 ]] && ADDED_STR="%F{green}+${ADDED}%f"
    [[ $REMOVED -gt 0 ]] && REMOVED_STR="%F{red}-${REMOVED}%f"

    # ahead/behind 情報を取得
    AHEAD_STR=""
    BEHIND_STR=""
    if git rev-parse --abbrev-ref @{u} &>/dev/null; then
      AHEAD=$(git rev-list --count @{u}..HEAD 2>/dev/null)
      BEHIND=$(git rev-list --count HEAD..@{u} 2>/dev/null)
      [[ $AHEAD  -gt 0 ]] && AHEAD_STR="%F{yellow}⇡${AHEAD}%f"
      [[ $BEHIND -gt 0 ]] && BEHIND_STR="%F{blue}⇣${BEHIND}%f"
    fi

    # 情報がある場合のみスペースを追加
    INFO_STR="${ADDED_STR}${REMOVED_STR}${AHEAD_STR}${BEHIND_STR}"
    if [[ -n "$INFO_STR" ]]; then
      GIT_DISPLAY="[(%F{white}${BRANCH_NAME}%f) ${INFO_STR}]"
    else
      GIT_DISPLAY="[(%F{white}${BRANCH_NAME}%f)]"
    fi
  else
    GIT_DISPLAY=""
  fi
}

PROMPT='%F{cyan}%n@%m%f %F{10}%~%f ${GIT_DISPLAY} %# '

################################
# zsh local settings
################################
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

