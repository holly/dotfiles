---
glob: "**/*.sh"
---

# Bash規約

- shebang: `#!/usr/bin/env bash`
- 厳格モード必須: `set -euo pipefail`、必要に応じて`set -C`（noclobber）
- インデント: 4スペース
- 変数名: 環境変数・定数は`UPPER_SNAKE_CASE`（`LOCAL_DIR`, `HOME_LOCAL_DIR`）
- クォート: 変数展開は必ずダブルクォートで囲む（`"$var"`）
- フォーマッター: shfmt（`-i 4 -ci`）
- リンター: ShellCheck
