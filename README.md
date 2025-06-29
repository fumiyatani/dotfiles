# dotfiles

## 設定方法
1. 本リポジトリをホームディレクトリにクローンする
```
cd ~/
git clone <repo URL>
```

2. 各スクリプトに実行権限を付与
```
cd dotfiles/
chmod +x setup_tmux_config.sh
chmod +x setup_git_config.sh
chmod +x setup_claude_code_config.sh

[option]
既存の .claude/ のリンクを確認
./setup_claude_code_config.sh --verify

```

3. スクリプトの実行
```
./setup_tmux_config.sh
./setup_git_config.sh
./setup_claude_code_config.sh
```

