---
name: git-flow
description: >
  ブランチの作成・切り替え・命名・保護ブランチの判断が必要なときに使う。
  「どのブランチで作業すべきか」「新しいブランチを作りたい」「ブランチ名はどうすべきか」
  「main や develop に直接コミットしようとしている」と判断したときにロードする。
  git-flow 形式のブランチ運用ルールと命名規則を定義する。
---

# git-flow スキル

git-flow 形式のブランチ運用ルールを定義する。
**main / master / develop への直接コミットは禁止。** 必ず専用ブランチで作業する。

---

## ブランチ種別・命名規則・運用ルール

| ブランチ | 命名パターン | 派生元 | マージ先 | 用途 |
|---|---|---|---|---|
| `feature/*` | `feature/<内容>` | `develop` | `develop` | 新機能開発 |
| `fix/*` | `fix/<内容>` | `develop` | `develop` | 通常のバグ修正 |
| `hotfix/*` | `hotfix/<内容>` | `main` | `main` + `develop` | 本番緊急修正 |
| `release/*` | `release/<バージョン>` | `develop` | `main` + `develop` | リリース準備 |
| `chore/*` | `chore/<内容>` | `develop` | `develop` | メンテナンス・ツール設定 |
| `docs/*` | `docs/<内容>` | `develop` | `develop` | ドキュメントのみの変更 |
| `refactor/*` | `refactor/<内容>` | `develop` | `develop` | リファクタリング |

### 命名例
```
feature/oauth2-login
fix/null-response-payment
hotfix/critical-auth-bypass
release/1.2.0
chore/upgrade-eslint-v9
docs/update-readme-setup
refactor/extract-query-builder
```

---

## 保護ブランチ

以下のブランチには **直接コミット禁止**：

- `main`
- `master`
- `develop`（直接コミット非推奨。各ブランチからのマージで更新する）

---

## 保護ブランチ検出時の対応

`git branch --show-current` の結果が `main` / `master` / `develop` だった場合、
**即座に止まり**、以下をユーザーに伝える：

```
⚠️ 現在 [ブランチ名] ブランチにいます。
このブランチには直接コミットできません。

作業内容に合わせてブランチを作成してください：

  git checkout -b feature/<内容>   # 新機能
  git checkout -b fix/<内容>       # バグ修正
  git checkout -b hotfix/<内容>    # 本番緊急修正
  git checkout -b chore/<内容>     # メンテナンス

どのブランチ名にしますか？
```

ブランチ名が決まったら、以下を提案して承認を得てから実行する：
```bash
git checkout -b <ブランチ名>
```
