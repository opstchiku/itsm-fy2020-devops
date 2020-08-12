# 各種決定の経緯

## 監視
- prometheus

## Slack通知
- やらない
  - 余力があったらやる？

## dockerやらない

各自PC環境のヒアリングの一環で、Windowsの人にはHyper-V が有効になっているかを確認したい
→ AndroidStudio (のちょっと古いバージョン)やVirtual Boxを使ってる人は無効化されてるはず。で、それだとDocker動かない

## LoadMap
- CI/CD → IaC の順番にする
  - 手動設定で流れを確認して、コード化したほうが分かりやすいはず

## Cloud9を利用する
  - AWSのコンソール上でターミナルとIDEを同時に使える
    - 環境差異を吸収できる
    - 裏ではEC2が立ち上がるので多少課金されるが無料枠に収まる見込み
- ターミナルとIDEがまとまったようなAWSのツール
  - (元は別サービスだったが買収された)
- AWSの管理コンソールから利用可能
  - 施策メンバーでWindowsやMacが

## AWSアカウントの共用
  - ルートユーザーはオーナー1名
    - このメンバーにも別途IAMユーザーを用意
  - 各メンバーにIAMを割り当てる
- 1つにまとまってる方が
  - ゴミ等の監視がしやすい
  - 清算申請が一人で済む

- ざっくり収まる計算

- 開設12か月以内のものなら、各自無料枠のEC2インスタンスでAnsibleを動かすという選択肢がある気がします

EC2やRDSはt2.microなら750h/月まで無料なので、ひとり40時間弱くらいまで使えそうです。
https://aws.amazon.com/jp/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc

Linuxのt2.micro使う分には 0.0152USD/時間、t2.mediumでも0.0608USD/時間位なので、
無料枠使い切ってても十分収まりそうな気はします
https://aws.amazon.com/jp/ec2/pricing/on-demand/
- ダメそうならチームごとに追加で新規取得しましょう
  - IaCやるなら環境が変わっても再現性が担保されてるはずw

## JenkinsのホストOSを Win or Linux
- Linux (採用)
  - EC2のコストが安い
    - Windowsの方が要求スペックが高いから、無料枠ならLinuxの方が楽
  - Remote Desktopが不要
    - Macで使うときには別アプリ入れないといけない...
    - (Windows10 Homeでもクライアントにはなれる)
- Windows
  - Jenkinsのコンソール外の部分がGUIで触れる
    - Linuxコマンドの学習コストが不要
    - ミドルウェア構築は今回範囲外となるのであまりメリットではない

## Gitのホスティング
- GitHub
  - いまは無料でprivateリポジトリが無制限ユーザー行ける
  - 発展形としてGithub Actionsにも手を出せる
    - 施策として時間的に取り込めるかは別問題
  - (ueda.t的には使い慣れてるから説明しやすい)
- Code Commit
  - AWS内のサービス
  - S3の課金があるので
  - なんでもAWSに押し込むと、境界線が分かんなくなる
- BackLog
  - 会社で契約してるのはこれだから事前準備はしやすい？
  - CodePipelineから扱えない
    - https://docs.aws.amazon.com/ja_jp/codepipeline/latest/userguide/reference-pipeline-structure.html#actions-valid-providers
    -  (やらなくてもいいんだけど...)

## GitHub
- freeプランでは
  - 2020年4月15日 ～ privateリポジトリもユーザー数無制限に
    - https://www.publickey1.jp/blog/20/githubactionscicd.html
  - Wikiは使えない
  - GitHub Actionsはpublicリポジトリのみ無料
- 色々施策の非公開情報を書き込みたいのでprivateにしときたい

