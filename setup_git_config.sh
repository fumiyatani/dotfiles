#!/bin/bash

if [ ! -L "$HOME/.gitconfig_shared" ]; then
  ln -s "$HOME/dotfiles/git/.gitconfig_shared" "$HOME/.gitconfig_shared"
  echo "gitconfig_shared シンボリックリンクを作成"
else
  echo "gitconfig_shared シンボリックリンクはすでに存在する"
fi

if [ ! -L "$HOME/.gitignore_global" ]; then
  ln -s "$HOME/dotfiles/git/.gitignore_global" "$HOME/.gitignore_global"
  echo "gitignore_global シンボリックリンクを作成"
else
  echo "gitignore_global シンボリックリンクはすでに存在する"
fi

if [ ! -L "$HOME/.stCommitMsg" ]; then
  ln -s "$HOME/dotfiles/git/.stCommitMsg" "$HOME/.stCommitMsg"
  echo "stCommitMsg シンボリックリンクを作成"
else
  echo "stCommitMsg シンボリックリンクはすでに存在する"
fi

# HOMEディレクトリの環境変数を展開してGit設定を適用
git config --global include.path "$HOME/.gitconfig_shared"
git config --global core.excludesfile "$HOME/.gitignore_global"
git config --global commit.template "$HOME/.stCommitMsg"

# 設定の確認
echo "Git 設定が適用されました:"
git config --global --list --show-origin
