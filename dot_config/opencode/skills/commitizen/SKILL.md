---
name: commitizen
description: >
  git のコミットメッセージを作成・レビュー・修正するときに使う。
  「コミットメッセージを考えて」「どんな type にすべきか」「メッセージの形式が合っているか確認して」
  と言われたときにロードする。Commitizen 形式の構造・タイプ定義・記述ルールを定義する。
---

# Commitizen スキル

Commitizen 形式のコミットメッセージ仕様を定義する。

---

## メッセージ構造

```
<type>(<scope>): <subject>

[本文（任意）]

[フッター（任意）]
```

---

## タイプ一覧

| タイプ | 使う場面 |
|---|---|
| `feat` | 新機能の追加 |
| `fix` | バグ修正 |
| `docs` | ドキュメントのみの変更 |
| `style` | フォーマット・空白の調整（ロジック変更なし） |
| `refactor` | リファクタリング（機能追加でも修正でもない） |
| `perf` | パフォーマンス改善 |
| `test` | テストの追加・修正 |
| `build` | ビルドシステムや依存関係の変更 |
| `ci` | CI/CD 設定の変更 |
| `chore` | メンテナンス作業・ツール設定 |
| `revert` | 以前のコミットの取り消し |

---

## subject の記述ルール

- **小文字**で書く
- 末尾に**ピリオドをつけない**
- **命令形**で書く（`add feature` であって `added feature` ではない）
- **最大 72 文字**
- `scope` は任意。変更が特定のモジュール・ディレクトリに限定される場合に付ける

---

## 記述例

```
feat(auth): add OAuth2 login support

fix(api): handle null response from payment gateway

docs: update README with new setup instructions

refactor(database): extract query builder into separate module

chore(deps): upgrade eslint to v9
```

---

## 破壊的変更（Breaking Changes）

API の互換性が壊れる変更には `!` と `BREAKING CHANGE:` フッターを付ける：

```
feat(api)!: change authentication endpoint response format

BREAKING CHANGE: レスポンスが `access_token` から `token` に変わった
```
