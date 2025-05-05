#!/bin/bash

set -e

MAINT_FLAG="/tmp/maintenance.flag"
if [ -f "$MAINT_FLAG" ]; then
  rm "$MAINT_FLAG"
  echo "[INFO] フラグ削除済み"
else
  echo "[INFO] すでに削除済み"
fi

echo "default 0;" > /etc/nginx/maintenance_flag.conf
nginx -s reload
