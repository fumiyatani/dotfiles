---
description: PRテンプレートを参照し、Git情報（コミット履歴・変更ファイル）を元にPRを作成する
allowed-tools: Bash, Read
---

# PR作成

PRテンプレートを参照し、Git情報に基づいてPRを作成します。

## 前提条件

- git push が完了していること

## 実行手順

### 1. 既存PRを確認

まず、現在のブランチで既にPRが作成されているか確認してください：

```bash
# 現在のブランチ名を取得
CURRENT_BRANCH=$(git branch --show-current)

# このブランチの既存PRを確認
gh pr list --head $CURRENT_BRANCH
```

**既存PRがある場合:**
- PR番号を取得し、手順5で `gh pr edit <番号>` を使用して更新
- 「既存PR #X を更新します」とユーザーに伝える

**既存PRがない場合:**
- 手順5で `gh pr create` を使用して新規作成

### 2. PRテンプレートを確認

以下の順序でPRテンプレートを探し、内容を確認してください：

```bash
# 優先順位順に確認
cat .github/PULL_REQUEST_TEMPLATE.md 2>/dev/null || \
cat .github/pull_request_template.md 2>/dev/null || \
cat docs/PULL_REQUEST_TEMPLATE.md 2>/dev/null || \
cat PULL_REQUEST_TEMPLATE.md 2>/dev/null || \
echo "PRテンプレートが見つかりません"
```

テンプレートが見つからない場合は、ユーザーにPRのフォーマットを確認してください。

### 3. 情報を収集

PR作成に必要な情報を収集してください：

#### Git情報（主な情報源）
```bash
# 現在のブランチ名
git branch --show-current

# コミット一覧（このブランチで追加されたもの）
git log origin/main..HEAD --oneline

# 変更ファイル一覧
git diff origin/main --name-only

# 変更の統計（追加/削除行数）
git diff origin/main --stat
```

#### 実装計画書（補助情報・存在する場合のみ）
- 目的・背景（「目的」セクションの補足に使用）
- 関連チケットURL（あれば）

### 4. PR本文を作成

PRテンプレートに従って、以下の情報を埋めてください：

| 項目 | 情報源 |
|------|--------|
| タイトル | ブランチ名・コミット内容から、変更を最もよく表す簡潔なタイトルを生成 |
| 目的 | コミットメッセージから要約 / 関連チケットURL |
| 変更点・主な仕様 | コミット一覧 + 変更ファイルから読み取った内容 |
| 確認事項 | チェックリストを確認し、該当項目をチェック |
| スクショ | UI変更がある場合は人が添付 |

### 5. PRを作成または更新

**既存PRがある場合（更新）:**

```bash
gh pr edit <PR番号> --title "[タイトル]" --body "[本文]"
```

または、本文が長い場合：

```bash
gh pr edit <PR番号> --title "[タイトル]" --body-file /tmp/pr_body.md
```

**既存PRがない場合（新規作成・draft状態）:**

```bash
gh pr create --draft --title "[タイトル]" --body "[本文]"
```

または、本文が長い場合：

```bash
gh pr create --draft --title "[タイトル]" --body-file /tmp/pr_body.md
```

### 6. 完了報告

**既存PRを更新した場合:**
```
PR #X を更新しました。

- PR URL: [PRのURL]
- タイトル: [PRタイトル]
```

**新規PRを作成した場合:**
```
PRを作成しました。

- PR URL: [作成されたPRのURL]
- タイトル: [PRタイトル]

内容を確認し、問題なければ Ready for Review に変更をお願いします。
```

---

## PRタイトルの命名規則

PR内で行われた変更を最もよく表す、簡潔なタイトルをつけてください。

例：
- `ユーザープロフィール画像のアップロード機能を追加`
- `ログイン時のバリデーションエラーを修正`
- `認証ロジックをリファクタリング`

---

## 注意事項

- PRは必ず **draft状態** で作成する
- PR Open（Ready for Review）は人が実行する
- テンプレートの項目は勝手に削除しない（空欄でも残す）
