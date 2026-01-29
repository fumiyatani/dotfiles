#!/bin/bash

PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# iTerm2の設定ファイルが存在するか確認
if [[ -f "$PLIST" ]]; then
  # Left Option key を Esc+ に設定
  /usr/libexec/PlistBuddy -c "Set ':New Bookmarks:0:Option Key Sends' 2" "$PLIST"
  echo "iTerm2: Left Option key を Esc+ に設定しました"

  # 背景の透過率を設定（0.0=不透明、1.0=完全透過）
  /usr/libexec/PlistBuddy -c "Set ':New Bookmarks:0:Transparency' 0.5" "$PLIST"
  echo "iTerm2: 背景の透過率を 50% に設定しました"
else
  echo "iTerm2の設定ファイルが見つかりません。iTerm2を一度起動してから再実行してください。"
fi
