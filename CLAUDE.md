# CLAUDE.md

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

## 禁止事項

- コミットにシークレット（APIキー、トークン等）を含めない（Bitwardenテンプレートを使用）
- パスにスペースを含むディレクトリ・ファイル名を使用しない
- sudoコマンドの実行は禁止（`rm -rf *`, `git push --force*`, `dd *`等も禁止）

## 規約・手順

以下のファイルを必要に応じて参照すること（lazy loading）。

- Lua/Neovim規約: @.opencode/rules/lua-neovim.md
- Neovim設定の構造: @.opencode/rules/neovim-structure.md
- Bash規約: @.opencode/rules/bash.md
- Fish規約: @.opencode/rules/fish.md
- chezmoiテンプレート規約: @.opencode/rules/chezmoi-template.md
- Gitコミットメッセージ規約: @.opencode/rules/git-commit.md
- エラーハンドリング: @.opencode/skills/error-handling/SKILL.md
- 編集時の注意: @.opencode/skills/editing-guidelines/SKILL.md
- chezmoiコマンド: @.opencode/commands/chezmoi.md
