#!/bin/bash

# infoファイルを削除
rm *.info

rm -r ./coverage/**/*.*

# build directory作成
mkdir -p build
cd build
rm -r *

# Coverage Build
cmake -DCMAKE_BUILD_TYPE=Coverage ..
make

cd ../
ls ./bin

# Run GTest
./bin/test1
./bin/test2
./bin/test3

# Covrerage
lcov --capture --directory . --base-directory "$PROJECT_ROOT" --output-file coverage.info

# プロジェクトルートからの相対パスに変換
lcov --prefix "$PROJECT_ROOT" --output-file coverage.info --output-file coverage.info

# 不要なコードを除去
lcov --remove coverage.info '/usr/*' '*/gtest/*' '*/bits/*' '*/ext/*' --output-file coverage_filtered.info

# HTMLレポート作成
genhtml coverage_filtered.info --prefix "$PROJECT_ROOT" --output-directory coverage


echo "Coverage Report Generated in 'build/coverage'"