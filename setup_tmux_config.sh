#!/bin/bash

if [ ! -L "$HOME/.tmux.conf" ]; then
  ln -s "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"
  echo "tmux.conf シンボリックリンクを作成"
else
  echo "tmux.conf シンボリックリンクはすでに存在する"
fi

# 設定の確認
echo "tmux 設定が適用されました:"
ls -l "$HOME/.tmux.conf"
