# /statusline-test

statusline.sh の動作テストを実行します。

## 目的

Claude Code のランタイム外で statusline.sh を単体テストするためのコマンドです。

## 実行内容

1. 複数パターンのダミー JSON データを生成
   - 低コンテキスト使用率（19%）
   - 中コンテキスト使用率（55%）
   - 高コンテキスト使用率（85%）
2. 各パターンで statusline.sh を実行
3. 出力を確認（色付き表示）

## テストパターン

### パターン 1: 低コンテキスト使用率（緑）

```bash
echo '{"model":{"display_name":"Sonnet 4.5"},"context_window":{"used_percentage":19.5}}' | ~/.claude/statusline.sh
```

期待される出力: `Sonnet 4.5 | Ctx: 19% | <branch>` （Ctx は緑色）

### パターン 2: 中コンテキスト使用率（黄）

```bash
echo '{"model":{"display_name":"Opus 4.1"},"context_window":{"used_percentage":55.2}}' | ~/.claude/statusline.sh
```

期待される出力: `Opus 4.1 | Ctx: 55% | <branch>` （Ctx は黄色）

### パターン 3: 高コンテキスト使用率（赤）

```bash
echo '{"model":{"display_name":"Haiku"},"context_window":{"used_percentage":85.7}}' | ~/.claude/statusline.sh
```

期待される出力: `Haiku | Ctx: 85% | <branch>` （Ctx は赤色）

## 使い方

```bash
/statusline-test
```

## 注意事項

- Git リポジトリ内で実行すると、ブランチ名も表示されます
- Git リポジトリ外で実行すると、ブランチ名は表示されません
- jq がインストールされていない場合は "jq required" エラーが表示されます

## 実装手順

1. 上記の3つのテストパターンを順次実行
2. それぞれの出力を確認
3. 色分けが正しく機能しているか確認
