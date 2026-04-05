# AGENTS.md

## 技術スタック

- bash/fish
- python
- perl
- zig

## リポジトリ概要

chezmoiで管理するdotfilesリポジトリ。RHEL系（CentOS/Fedora）とDebian系（Ubuntu）の両方に対応。
`chezmoi apply`で各ファイルを`$HOME`に配置する。

## ビルド/リント/テスト

このリポジトリは設定ファイル（dotfiles）であり、ビルド・テストは存在しない。

### chezmoiコマンド

- ファイル適用: `chezmoi apply -v`
- chezmoi設定編集: `chezmoi edit-config`
- ソースディレクトリへ移動: `chezmoi source-path`
- 変更確認: `chezmoi diff`

## 一般的なコーディング規約

### Lua（Neovim設定）

- インデント: 4スペース（`expandtab=true`, `tabstop=4`, `shiftwidth=4`）
- 文字列: 短い文字列はシングルクォート（`'shfmt'`）、長い文字列はダブルクォート
- require: 絶対パスで記述（`require("module")`）、相対パスは使わない
- プラグイン設定: lazy.nvimのspec形式（`event`/`keys`/`cmd`/`config`フィールド）
- 変数名: `snake_case`（ローカル変数）
- 1ファイル1プラグイン/1機能: `lua/plugins/`配下に分割
- コメント言語: 日本語

### Bash

- shebang: `#!/usr/bin/env bash`
- 厳格モード必須: `set -euo pipefail`、必要に応じて`set -C`（noclobber）
- インデント: 4スペース
- 変数名: 環境変数・定数は`UPPER_SNAKE_CASE`（`LOCAL_DIR`, `HOME_LOCAL_DIR`）
- クォート: 変数展開は必ずダブルクォートで囲む（`"$var"`）
- フォーマッター: shfmt（`-i 4 -ci`）
- リンター: ShellCheck

### Fish

- エイリアスではなく`abbr`を使うこと
- コマンド存在確認: `command -sq`を使用
- 環境変数: `set -gx`で設定

### chezmoiテンプレート

- Goテンプレート構文を使用（`.tmpl`拡張子）
- シークレット: Bitwarden CLI経由（`{{ (bitwardenFields "item" "name").field.value | trim }}`）
- OS判定: `{{ if eq .chezmoi.osRelease.idLike "rhel centos fedora" }}`
- データ変数: `.chezmoidata/common.toml`から参照（`{{ .name }}`, `{{ .email }}`）
- 暗号化: ageを使用（`encryption = "age"`）

### Gitコミットメッセージ

- Conventional Commits形式: `type: description`
- 絵文字をタイプの後に中央揃えで配置
- タイプ一覧: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- 例: `feat: ✨ Add ZLS configuration for Zig language server`

### Neovim設定の構造

- エントリーポイント: `dot_config/nvim/init.lua`（lazy.nvimブートストラップ）
- 設定読み込み順: `options.lua` → `keymaps.lua` → その他`config/*.lua`（glob順）
- LSP設定: `lua/lsp/`にサーバーごとに1ファイル（`zls.lua`, `bashls.lua`等）
- リーダーキー: Space
- telescopeマッピングはリーダーキーなし（`ff`, `fg`, `fb`, `fo`, `fh`）

## エラーハンドリング

- Bash: `set -euo pipefail`で未定義変数・パイプエラーを即座に検知
- Lua: 宣言的設定が主。必要に応じて`pcall`を使用
- Fish: `command -sq`でコマンド存在確認後に機能を定義

## 禁止事項

- コミットにシークレット（APIキー、トークン等）を含めない（Bitwardenテンプレートを使用）
- パスにスペースを含むディレクトリ・ファイル名を使用しない
- sudoコマンドの実行は禁止（`rm -rf *`, `git push --force*`, `dd *`等も禁止）

## 編集時の注意

- 既存ファイルのスタイルに合わせること
- 新しいLSPサーバーを追加する場合: `lua/lsp/`に新規ファイルを作成し、`lua/config/lsp.lua`のglobで自動読み込みされる
- 新しいNeovimプラグインを追加する場合: `lua/plugins/`に新規ファイルを作成し、lazy.nvimのspec形式に従う
- fishのabbrevを追加する場合: `dot_config/fish/config.fish`に追記
