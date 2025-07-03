# Homebrew for Intel Chip and Apple Chip
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi


# Java
export JAVA_HOME="/opt/homebrew/Caskroom/temurin@17/libexec/openjdk.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"

# Node.js (nodebrew)
export PATH="$HOME/.nodebrew/current/bin:$PATH"

# Ruby (rbenv)
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# UNIX Commands
export PATH="/usr/local/bin:$PATH"

# Python (pyenv)
export PATH="$HOME/.pyenv/shims:$PATH"

# Flutter (FVM)
export PATH="$HOME/fvm/default/bin:$PATH"

# Dart Package Cache
export PATH="$HOME/.pub-cache/bin:$PATH"

# Homebrew for Intel Chip and Apple Chip
if [ -x "/opt/homebrew/bin/brew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x "/usr/local/bin/brew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# OrbStack Settings (installed only)
if [ -d "$HOME/.orbstack" ]; then
  source "$HOME/.orbstack/shell/init.zsh"
fi

# load `.zprofile.local`
if [ -f "$HOME/.zprofile.local" ]; then
  source "$HOME/.zprofile.local"
fi
