################################
# User-defined Aliases
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

# vi
alias vi='vim'
