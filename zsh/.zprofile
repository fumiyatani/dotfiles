############################################################
# 1) Homebrew の環境変数を読み込む
############################################################
# Homebrew (Apple Silicon)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

############################################################
# 2) ランタイムとツールパス
############################################################

# Java 17
if /usr/libexec/java_home -V 2>/dev/null | grep -q "17"; then
  export JAVA_HOME="$(/usr/libexec/java_home -v 17)"
elif [[ -d "/opt/homebrew/Caskroom/temurin@17" ]]; then
  export JAVA_HOME="/opt/homebrew/Caskroom/temurin@17/libexec/openjdk.jdk/Contents/Home"
fi
[[ -n $JAVA_HOME ]] && PATH="$JAVA_HOME/bin:$PATH"

# Node (nodebrew)
PATH="$HOME/.nodebrew/current/bin:$PATH"

# Ruby (rbenv) – 存在するときだけ初期化
if command -v rbenv &>/dev/null; then
  PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# Python (pyenv) – 存在するときだけ初期化
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - zsh)"
fi

# Flutter (global) と FVM default
PATH="$HOME/flutter/bin:$HOME/fvm/default/bin:$PATH"

# Dart pub cache
PATH="$HOME/.pub-cache/bin:$PATH"

# Android adb
PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

############################################################
# 3) OrbStack（インストールされていれば読み込み）
############################################################
[[ -d "$HOME/.orbstack" ]] && source "$HOME/.orbstack/shell/init.zsh"

############################################################
# 4) 端末固有・機密用の追加設定
############################################################
[[ -f "$HOME/.zprofile.local" ]] && source "$HOME/.zprofile.local"

