################################
# Aliases
################################
# Git
alias g='git'

# Docker
alias d='docker'
alias dc='docker compose'

# PostgreSQL (for Homebrew)
alias psqlstart='brew services start postgresql'
alias psqlstop='brew services stop postgresql'

# Firebase (Android) – debug log
alias firelog='adb shell setprop log.tag.FA VERBOSE && \
               adb shell setprop log.tag.FA-SVC VERBOSE && \
               adb logcat -v time -s FA FA-SVC'

# FVM / Flutter
alias f='fvm'
alias ff='fvm flutter'
alias fd='fvm dart'
alias fdb='fvm dart run build_runner build -d'

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

    GIT_DISPLAY="(${BRANCH_NAME}${ADDED_STR}${REMOVED_STR})"
  else
    GIT_DISPLAY=""
  fi
}

PROMPT='%F{cyan}%n@%m%f %F{green}%~%f ${GIT_DISPLAY} %# '

################################
# zsh local settings
################################
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
