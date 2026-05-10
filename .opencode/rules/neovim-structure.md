---
glob: "dot_config/nvim/**/*.lua"
---

# Neovim設定の構造

- エントリーポイント: `dot_config/nvim/init.lua`（lazy.nvimブートストラップ）
- 設定読み込み順: `options.lua` → `keymaps.lua` → その他`config/*.lua`（glob順）
- LSP設定: `lua/lsp/`にサーバーごとに1ファイル（`zls.lua`, `bashls.lua`等）
- リーダーキー: Space
- telescopeマッピングはリーダーキーなし（`ff`, `fg`, `fb`, `fo`, `fh`）
