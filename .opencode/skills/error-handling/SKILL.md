---
name: error-handling
description: 各言語のエラーハンドリング規約
---

# エラーハンドリング

- Bash: `set -euo pipefail`で未定義変数・パイプエラーを即座に検知
- Lua: 宣言的設定が主。必要に応じて`pcall`を使用
- Fish: `command -sq`でコマンド存在確認後に機能を定義
