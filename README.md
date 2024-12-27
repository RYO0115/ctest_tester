# Google Test Code Coverage Test

## 概要

このプロジェクトはC++, CMakeで構成されたプロジェクトに対してどのようにコードカバレッジを確認するのかを確認するためのプロジェクト。

## コンパイル方法

    docker-compose up --build

## カバレッジ結果確認

/{プロジェクトルートディレクトリ}/coverage/index.html

を起動し、ブラウザで確認完了


## その他、今後のToDo

Azure Dev Opsで自動実行、Azure Dev Ops上でのカバレッジの表示方法

[PublishCodeCoverageResults](https://learn.microsoft.com/ja-jp/azure/devops/pipelines/tasks/reference/publish-code-coverage-results-v2?view=azure-pipelines)というカバレッジを表示するAPIが用意されているらしい。

これを使えば諸々を表示できそう。


```yaml
trigger:
- main

pool:
  vmImage: 'ubuntu-latest'

steps:
# ビルドとテストの実行
- script: |
    mkdir -p build
    cd build
    cmake -DCMAKE_BUILD_TYPE=Coverage ..
    make
    ctest
    lcov --capture --directory . --output-file coverage.info
    lcov --remove coverage.info '/usr/*' '*/gtest/*' '*/bits/*' --output-file coverage_filtered.info
    genhtml coverage_filtered.info --output-directory coverage
  displayName: 'Build and Generate Coverage'

# HTMLレポートをアーティファクトとして公開
- task: PublishPipelineArtifact@1
  inputs:
    targetPath: 'build/coverage'
    artifact: 'coverage_html'
    publishLocation: 'pipeline'
  displayName: 'Publish Coverage Report'

# Azure DevOps上でHTMLを公開
- task: PublishCodeCoverageResults@1
  inputs:
    codeCoverageTool: 'Cobertura'
    summaryFileLocation: '$(Build.SourcesDirectory)/build/coverage/coverage_filtered.info'
    reportDirectory: '$(Build.SourcesDirectory)/build/coverage'
  displayName: 'Publish Code Coverage Results'

```