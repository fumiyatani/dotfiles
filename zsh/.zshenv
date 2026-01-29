# ローカルユーザー PATH
export PATH="$HOME/.local/bin:$PATH"

# Rust (cargo) – ファイルがあるときだけ読み込む
[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

