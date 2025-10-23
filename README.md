# Google Test Code Coverage Test

[![CI/CD Pipeline](https://github.com/RYO0115/ctest_tester/actions/workflows/ci.yml/badge.svg)](https://github.com/RYO0115/ctest_tester/actions/workflows/ci.yml)
[![codecov](https://codecov.io/gh/RYO0115/ctest_tester/branch/master/graph/badge.svg)](https://codecov.io/gh/RYO0115/ctest_tester)

## 概要

このプロジェクトはC++, CMakeで構成されたプロジェクトに対してどのようにコードカバレッジを確認するのかを確認するためのプロジェクト。
GitHub Actionsを使用した自動ビルド・テスト・カバレッジ測定システムを含みます。

## 🚀 GitHub Actions CI/CD

GitHub Actionsにより以下が自動実行されます：

- **自動ビルド**: プッシュ・プルリクエスト時に自動ビルド
- **自動テスト**: GoogleTest + CTestでテスト実行
- **コードカバレッジ**: lcov + gcovrでカバレッジ測定
- **レポート生成**: HTMLとXML形式でカバレッジレポート生成
- **アーティファクト**: テスト結果とカバレッジレポートを保存

## ローカル開発

### 依存関係のインストール

```bash
# Ubuntu/Debian
sudo apt-get install cmake build-essential libgtest-dev lcov gcovr

# GTestのビルド（必要に応じて）
cd /usr/src/gtest
sudo cmake CMakeLists.txt
sudo make
sudo cp lib/*.a /usr/lib
```

### ビルドとテスト

```bash
# ビルド
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Coverage ..
make

# テスト実行
ctest --output-on-failure

# カバレッジ生成
lcov --capture --directory . --output-file coverage.info
lcov --remove coverage.info '/usr/*' '*/gtest/*' '*/bits/*' --output-file coverage_filtered.info
genhtml coverage_filtered.info --output-directory coverage_html
```

## Docker使用（従来の方法）

    docker-compose up --build

## カバレッジ結果確認

- **ローカル**: `/{プロジェクトルートディレクトリ}/coverage/index.html`
- **GitHub Actions**: ActionsのArtifactsからHTMLレポートをダウンロード
- **Codecov**: リポジトリページのバッジからアクセス

## 🔧 設定済み機能

### GitHub Actions ワークフロー

- **Basic CI** (`.github/workflows/ci.yml`): シンプルなビルド・テスト・カバレッジパイプライン
- **Advanced CI** (`.github/workflows/advanced-ci.yml`): マトリックスビルド、複数OS・コンパイラ対応

### カバレッジツール統合

- **Codecov**: プルリクエストにカバレッジコメント自動投稿
- **アーティファクト**: HTMLレポートとXMLデータの保存

## 📊 Azure Pipeline との比較

| 機能 | Azure Pipeline | GitHub Actions |
|------|----------------|----------------|
| トリガー | `trigger: main` | `on: push: branches: [main]` |
| ビルド環境 | `vmImage: ubuntu-latest` | `runs-on: ubuntu-latest` |
| カバレッジ | PublishCodeCoverageResults | Codecov + Artifacts |
| アーティファクト | PublishPipelineArtifact | upload-artifact |
| マトリックス | jobs + strategy | strategy.matrix |

## 🚀 セットアップ手順

1. `.github/workflows/` フォルダをGitHubリポジトリにプッシュ
2. [Codecov](https://codecov.io)でリポジトリを連携（オプション）
3. プッシュまたはプルリクエスト作成で自動実行開始

## 🔍 従来のAzure Pipeline設定（参考）