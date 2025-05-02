#!/bin/bash
# Usage: ./scripts/start-maintenance.sh "メンテナンス内容（Markdown形式）"

set -e

if [ -z "$1" ]; then
  echo "エラーメッセージ: メンテナンス内容を引数に渡してください"
  exit 1
fi

# create maintenance flag
MAINT_FLAG="/tmp/maintenance.flag"
echo "1" > "$MAINT_FLAG"
echo "[INFO] メンテナンスフラグ $MAINT_FLAG を作成しました"

# update now.md
echo "$1" > content/now.md

# commit and push
DATE=$(date +%Y-%m-%dT%H-%M)
git add content/now.md
if git diff --cached --quiet; then
  echo "[INFO] 内容に変更がないためコミットをスキップします"
else
  git commit -m "start maintenance at $DATE"
  git push
  echo "[INFO] now.md を更新して push 済みです"
fi