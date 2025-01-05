#!/bin/bash

# エラー時にスクリプトを終了
set -e

# ビルドディレクトリ
BUILD_DIR="build"



# テスト結果出力ディレクトリとファイル名
TEST_RESULTS_DIR="${BUILD_DIR}/test_results"
TEST_RESULTS_FILE="${TEST_RESULTS_DIR}/test_results.xml"

# 必要なディレクトリを作成
mkdir -p "${TEST_RESULTS_DIR}"

# 実行可能ファイルのパス（プロジェクト構造に応じて変更）
#TEST_EXECUTABLE="${BUILD_DIR}/test_binary"
TEST_EXECUTABLE="./bin"

# GTestの実行
if [[ -x "${TEST_EXECUTABLE}" ]]; then
  echo "Running GTest tests..."
  #"${TEST_EXECUTABLE}" --gtest_output=xml:${TEST_RESULTS_FILE}
  cd ${BUILD_DIR}
  ls
  ctest --output-on-failure --gtest_output=xml:${TEST_RESULTS_FILE}
  echo "Test results saved to ${TEST_RESULTS_FILE}"
  cd ../
else
  echo "Error: Test executable not found or not executable: ${TEST_EXECUTABLE}"
  exit 1
fi

# テスト結果を表示（任意）
if command -v cat > /dev/null && [[ -f "${TEST_RESULTS_FILE}" ]]; then
  echo "==== TEST RESULTS (XML) ===="
  cat "${TEST_RESULTS_FILE}"
  echo "============================"
fi

# テスト結果のステータスを確認
TEST_STATUS=$(grep -c '<failure' "${TEST_RESULTS_FILE}" || true)

if [[ "${TEST_STATUS}" -ne 0 ]]; then
  echo "Some tests failed. Check the test results for more details."
  exit 1
else
  echo "All tests passed successfully."
fi
