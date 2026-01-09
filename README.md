# dotfiles

> Apple Silicon Mac 用の開発環境設定

## 前提条件

- macOS（Apple Silicon）

## 管理している設定

- **zsh**: Oh My Zsh + プラグイン（autosuggestions, completions, syntax-highlighting）
- **Homebrew**: Brewfile で開発ツール・CLI・フォントを管理
- **Claude Code**: カスタムコマンド・設定・MCP統合
- **Git**: `.gitconfig` と `.gitignore_global`
- **tmux**: `.tmux.conf`
- **iTerm2**: Option キーの設定

## セットアップ手順

### 1. Homebrew をインストール

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. リポジトリをクローン

```bash
cd ~
git clone https://github.com/fumiyatani/dotfiles.git
cd dotfiles
```

### 3. Homebrew でパッケージをインストール

```bash
brew bundle --file=homebrew/Brewfile
```

### 4. Oh My Zsh をインストール

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 5. GNU Stow で設定をリンク

```bash
stow claude git iterm2 tmux zsh
stow --target=$HOME homebrew
```

### 6. iTerm2 の設定を適用

```bash
./iterm2/setup-iterm2.sh
```

### 7. シェルを再起動

```bash
exec zsh
```

## 設定の更新方法

### ファイルの内容を編集した場合

既存ファイル（例: `.zshrc`）の内容を変更した場合は、シェルの再起動のみで反映されます。

```bash
exec zsh
```

### ファイルの追加・削除をした場合

新しいファイルを追加、または既存ファイルを削除した場合は、リンクの再作成が必要です。

```bash
cd ~/dotfiles
stow -R <パッケージ名>  # 例: stow -R zsh
exec zsh
```

| 操作 | `stow -R` | `exec zsh` |
|------|-----------|-----------|
| ファイルの内容を編集 | 不要 | 必要 |
| ファイルを追加・削除 | 必要 | 必要 |

