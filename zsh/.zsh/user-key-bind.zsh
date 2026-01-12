################################
# User Key Bindings
################################
# ターミナルでの単語単位操作のキーバインド設定

# Option + Backspace: 単語削除
bindkey '^[^?' backward-kill-word

# Option + ←: 単語単位で左移動
bindkey '^[[1;3D' backward-word

# Option + →: 単語単位で右移動
bindkey '^[[1;3C' forward-word
