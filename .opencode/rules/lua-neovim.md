---
glob: "dot_config/nvim/**/*.lua"
---

# Lua（Neovim設定）規約

- インデント: 4スペース（`expandtab=true`, `tabstop=4`, `shiftwidth=4`）
- 文字列: 短い文字列はシングルクォート（`'shfmt'`）、長い文字列はダブルクォート
- require: 絶対パスで記述（`require("module")`）、相対パスは使わない
- プラグイン設定: lazy.nvimのspec形式（`event`/`keys`/`cmd`/`config`フィールド）
- 変数名: `snake_case`（ローカル変数）
- 1ファイル1プラグイン/1機能: `lua/plugins/`配下に分割
- コメント言語: 日本語
