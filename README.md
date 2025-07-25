# dotfiles

## 設定方法

このリポジトリではGNU Stowを使用してシンボリックリンクを管理しています。

1. 本リポジトリをホームディレクトリにクローンする
```bash
cd ~/
git clone <repo URL>
```

2. GNU Stowをインストール
```bash
brew install stow
```

3. Stowを使用してシンボリックリンクを作成
```bash
cd dotfiles/
stow claude tmux git zsh
stow --target=$HOME homebrew
```

**変更した設定を反映させる**
```bash
stow -R <対象パッケージ>
```

## 設定内容

- **Claude Code**: `.claude/` ディレクトリの設定
- **Git**: `.gitconfig` と `.gitignore_global` の設定
- **tmux**: `.tmux.conf` の設定

