#!/bin/bash

input=$(cat)

# jq チェック
command -v jq >/dev/null 2>&1 || { echo "jq required"; exit 1; }

# モデル名
MODEL=$(echo "$input" | jq -r '.model.display_name // "---"')

# コンテキスト使用率（整数）
PERCENT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
PERCENT=${PERCENT:-0}  # 空の場合は0

# Gitブランチ
BRANCH=$(git branch --show-current 2>/dev/null || echo "")

# 色定義
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'
CYAN='\033[36m'
MAGENTA='\033[35m'
RESET='\033[0m'

# コンテキスト色分け
if [ "$PERCENT" -ge 80 ]; then
  CTX_COLOR=$RED
elif [ "$PERCENT" -ge 50 ]; then
  CTX_COLOR=$YELLOW
else
  CTX_COLOR=$GREEN
fi

# 出力
if [ -n "$BRANCH" ]; then
  printf "${CYAN}%s${RESET} | ${CTX_COLOR}Ctx: %d%%${RESET} | ${MAGENTA}%s${RESET}\n" "$MODEL" "$PERCENT" "$BRANCH"
else
  printf "${CYAN}%s${RESET} | ${CTX_COLOR}Ctx: %d%%${RESET}\n" "$MODEL" "$PERCENT"
fi
