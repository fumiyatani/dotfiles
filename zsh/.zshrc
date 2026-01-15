# Load oh my zsh 
[[ -f "$HOME/.zsh/omz.zsh" ]] && source "$HOME/.zsh/omz.zsh"

# Load brew-managed zsh plugins
[[ -f "$HOME/.zsh/brew-plugins.zsh" ]] && source "$HOME/.zsh/brew-plugins.zsh"

# Load user-defined aliases
[[ -f "$HOME/.zsh/user-aliases.zsh" ]] && source "$HOME/.zsh/user-aliases.zsh"

# Load user key bindings
[[ -f "$HOME/.zsh/user-key-bind.zsh" ]] && source "$HOME/.zsh/user-key-bind.zsh"

# Load user prompt configuration
[[ -f "$HOME/.zsh/user-prompt.zsh" ]] && source "$HOME/.zsh/user-prompt.zsh"

################################
# Completion
################################
# Dart CLI
[[ -f "$HOME/.dart-cli-completion/zsh-config.zsh" ]] && \
  source "$HOME/.dart-cli-completion/zsh-config.zsh" || true

################################
# zsh local settings
################################
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

