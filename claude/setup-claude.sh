#!/bin/bash

# Claude Code 設定のセットアップスクリプト

echo "Setting up Claude Code configuration..."

# statusline.sh に実行権限を付与
if [ -f "$HOME/.claude/statusline.sh" ]; then
  chmod +x "$HOME/.claude/statusline.sh"
  echo "✓ Set executable permission for statusline.sh"
else
  echo "⚠ statusline.sh not found (run 'stow claude' first)"
  exit 1
fi

echo "✓ Claude Code setup complete!"
