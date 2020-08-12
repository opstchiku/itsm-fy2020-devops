## 運営が事前準備すべきもの
- AWSアカウント
  - ルートアカウントを一つだけ
    - 要クレカ
- 各メンバー分のIAM
  - 基本的にフル権限与える
  
- AWSアカウント
  - 全メンバーで1アカウント共用
    - あくまで請求的な意味合いで
    - IAMは分ける
  - 招待作業が必要
  - 不要なインスタンスの停止Lambda
- 施策用Slack
  - 主目的はアプリからの通知の為
    - 福岡メンバー以外も参画するので
    - しかもメッセージが流れまくるので1万件まで
  - 招待作業が必要
- githubアカウント
  - 招待作業が必要

## AMIで大枠ははしょる
- で、AMIの作成手順はgithubに残す
- opst_fy2020_devops
  - main
    - team
      - feature/Asan
      - feature/Bsan

## 議論したいこと
- githubのリポジトリ戦略
  - カンニングを許容するか
  - fork
  - private/public
- リポジトリ名
  - itsm_fy2020_devops
- リポジトリごと分けたほうが良いのかも？
  - 初期設定を頑張るならね
- 言語を何にするか
  - Jenkins / Github Action / CodeBuild どれでも簡単にビルドできるやつ。あとlocalでも
    - CodeBuild は、Java、Ruby、Python、Go、Node.js、Android、.NET Core、PHP、Docker
  - ビルド速い奴が良い
  - ユニットテスト書きやすい奴がいい
- コンソール名
- draw.io
- 実は各自リポジトリ作った方がいいんだろうか？
  - githubのprガードを0から試してみる場合
- Lambdaや請求アラートの設定はバッチ化したい



reveal.js 試す