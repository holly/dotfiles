---
name: editing-guidelines
description: ファイル編集時の注意事項と禁止事項
---

# 編集時の注意

- 既存ファイルのスタイルに合わせること
- 新しいLSPサーバーを追加する場合: `lua/lsp/`に新規ファイルを作成し、`lua/config/lsp.lua`のglobで自動読み込みされる
- 新しいNeovimプラグインを追加する場合: `lua/plugins/`に新規ファイルを作成し、lazy.nvimのspec形式に従う
- fishのabbrevを追加する場合: `dot_config/fish/config.fish`に追記

# 禁止事項

- コミットにシークレット（APIキー、トークン等）を含めない（Bitwardenテンプレートを使用）
- パスにスペースを含むディレクトリ・ファイル名を使用しない
- sudoコマンドの実行は禁止（`rm -rf *`, `git push --force*`, `dd *`等も禁止）
