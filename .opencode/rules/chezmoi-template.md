---
glob: "**/*.tmpl"
---

# chezmoiテンプレート規約

- Goテンプレート構文を使用（`.tmpl`拡張子）
- シークレット: Bitwarden CLI経由（`{{ (bitwardenFields "item" "name").field.value | trim }}`）
- OS判定: `{{ if eq .chezmoi.osRelease.idLike "rhel centos fedora" }}`
- データ変数: `.chezmoidata/common.toml`から参照（`{{ .name }}`, `{{ .email }}`）
- 暗号化: ageを使用（`encryption = "age"`）
