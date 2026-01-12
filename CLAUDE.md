# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a **dotfiles repository** for Apple Silicon Mac development environment configuration, managed via **GNU Stow**.

## Key Architecture

### Stow Package Structure

この dotfiles リポジトリは **GNU Stow** でシンボリックリンクを管理しています。各ディレクトリが "パッケージ" として機能します：

```
dotfiles/
├── zsh/              # Zsh設定パッケージ
│   ├── .zshrc
│   ├── .zprofile
│   ├── .zshenv
│   └── .zsh/         # モジュール化された設定
│       ├── omz.zsh
│       ├── brew-plugins.zsh
│       └── user-aliases.zsh
├── git/              # Git設定パッケージ
│   ├── .gitconfig_shared
│   └── .gitignore_global
├── tmux/             # Tmux設定パッケージ
│   └── .tmux.conf
├── claude/           # Claude Code設定パッケージ
│   └── .claude/
│       ├── commands/ # カスタムコマンド
│       └── skills/   # カスタムスキル
└── homebrew/         # Homebrewパッケージリスト
    └── Brewfile
```

### Zsh Configuration Architecture

**重要**: `.zshrc` はモジュール化されており、実際の設定は `.zsh/` ディレクトリ内のファイルに分離されています：

- **omz.zsh**: Oh My Zsh の設定
- **brew-plugins.zsh**: Homebrew でインストールされた zsh プラグイン
- **user-aliases.zsh**: ユーザー定義のエイリアス（Git, Docker, PostgreSQL, Firebase, FVM/Flutter）
- 今後追加予定: `completions.zsh`, `prompt.zsh`

`.zshrc` ファイルは各モジュールを条件付き (`[[ -f ... ]] && source ...`) で読み込むだけのシンプルな構造です。

### Custom Claude Commands

`.claude/commands/` に以下のカスタムコマンドが定義されています：

- **self-review**: 現在のブランチの変更内容を体系的にレビュー
- **pr-create**: PR テンプレートを参照し、Git 情報を元に PR を作成
- **retro**: タスク完了後の振り返りと Claude Code 設定全体の改善提案

## Common Development Tasks

### Initial Setup

```bash
# Homebrew でパッケージをインストール
brew bundle --file=homebrew/Brewfile

# Oh My Zsh をインストール
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# GNU Stow で設定をリンク
stow claude git tmux zsh
stow --target=$HOME homebrew

# シェルを再起動
exec zsh
```

### Configuration Updates

**ファイルの内容を編集した場合**（例: `.zshrc` の中身を変更）:
```bash
exec zsh  # シェル再起動のみで反映
```

**ファイルを追加・削除した場合**（例: 新しい `.zsh` モジュールを追加）:
```bash
cd ~/dotfiles
stow -R <パッケージ名>  # 例: stow -R zsh
exec zsh
```

### Working with Zsh Configurations

Zsh 設定をリファクタリング・編集する際は：

1. **既存のモジュール化パターンに従う**: 新しい設定は `.zsh/` ディレクトリ内に独立したファイルとして作成
2. **ファイル命名規則**: `user-*` プレフィックスはユーザー定義の設定を示す（例: `user-aliases.zsh`）
3. **`.zshrc` の更新**: 新しいモジュールを追加したら `.zshrc` に読み込み処理を追加
4. **条件付き読み込み**: 必ず `[[ -f "$HOME/.zsh/filename.zsh" ]] && source "$HOME/.zsh/filename.zsh"` パターンを使用

### Git Workflow

- **ブランチ命名規則**: アンダースコア区切り（例: `refactor_zshrc_aliases`）
- **必ず新ブランチで作業**: 機能追加、リファクタリング、バグ修正は新ブランチ上で実施
- **計画的な開発**: 不明点を解消してから実行計画を立て、コーディングを開始

### Temporary Files

リファクタリングや大きな変更を行う際の計画書などは、`tmp/` ディレクトリに作成してください（例: `tmp/zshrc-refactoring-plan.md`）。`tmp/` ディレクトリは .gitignore で無視されるため、一時的なファイルがリポジトリに混入しません。

## Communication

- **常に日本語で会話する**

## Development Philosophy

- Git で作成するブランチ名は `_` を使って単語を区切る
- 機能追加、リファクタリング、バグ修正などのコーディング作業を行う際は新たなブランチ上で作業する
- 不明点が存在する場合は確認を必ず取る
- 不明点を解消した上で、実行計画を立ててからコーディングを開始する
