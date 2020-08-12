# 1. CI/CD

## アドバイス
- GitHubアクセストークン
  - https://github.com/settings/keys


## ハンズオン
### Jenkins
- VPC作成
- AMIからjenkinsサーバーを起動
  - Jenkinsがインストールされた状態のAMIで施策実施
  - アプリまで動く状態にして渡す？
- SecurityGroup設定
  - 本当はbastion立てた方が良いけど
  - あとNAT欲しい
- ブラウザからJenkinsにアクセス
  - http://{各自のIP}:80880/
  - adminの初期パスワードはsshしないと分かんないかも
- DeployJobを設定してみよう
  - 自動デプロイパターンと手動デプロイパターン
  - 手動デプロイはブランチとかタグを選択出来るようにしたいなー
  - Why : 自動は検証環境向け / 手動は本番向け
- Deployを実行してみよう
  - gitに変更をpush
- テストを実行してみよう
  - そもそもテストの種類を知ろう？
  - リグレッションテスト
    - ユニットテスト
      - 単純なLogicのテスト
      - 現在時刻やDB周りの処理などをMock化したテスト
      - dockerを起動して実際にDB読み書きしちゃう破壊的なテスト
        - docker使えない環境を考慮して、フラグで起動の有無まで考慮する
      - カバレッジまでみたい
    - Postman (newman) を用いたAPI疎通テスト
      - 入れれる人はPostmanをまず試す。業務上インストールできない人はやらなくてOK
      - Cloud9からnewman実行
      - Collection Runnerを使った結合テスト
        - 前段の返却値も使いたい
    - Seleniumを使った画面テスト
      - 画像エビデンスの保存 ＆ 変更点の比較までやりたい
    - ベンチマーク
      - 今回はここまでできないかな
    - 標準出力
    - テスト結果通知したい
- 不正なテストを仕込んでデプロイを失敗させよう
- GitHubから呼んでprガードもできる
  - これは皆で設定体験までは出来ない
- Jenkinsのxmlを確認したい
  - Jobの設定がxmlで保存されていること
  - Jenkinsのビルド毎に新ディレクトリが作成されていること
- Port被りの解消

### Github Actions
- やったがいいとおもう
- Github依存

### CodePipelie
- やったがいいとおもう
- AWS依存
- CodeBuild
  - Jenkins使うパターンと
  - CodeBuild使うパターンを
- CodeDeploy
  - Inplace
    - お手軽
    
  - Blue/Greenデプロイを...
    - DevOpsを名乗るなら是非やりたいとこだが...
    - やるならALB設定が必要