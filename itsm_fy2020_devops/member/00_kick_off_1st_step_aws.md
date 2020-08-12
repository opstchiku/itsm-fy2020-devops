# AWS関連
## アドバイス
- 業務で使ってる人は別ブラウザでやった方がいいかも
- それかシークレットモードとか

## ルール
### 施策メンバー
- regionは `ap-northeast-1` のみ利用可とする
- 作業終わったら消す。これまじ大事
- 作業時間は原則23時(？)までとする (インスタンス停止)
- リソースにはメンバーが判別できるようにタグ付けする
### 運営メンバー
- 運営メンバーは請求額の確認をこまめに実施する
  - https://console.aws.amazon.com/billing/home?#/bills

## 本施策で利用する可能性のあるAWSサービス

### CLI
- コマンドライン。これはサービスというわけではない
  - aws xxx 
### マネジメントコンソール
#### billing
- 

#### IAM
- 

#### VPC
- NAT
  - まぁまぁお高いから悩ましい
- Security Group
- EC2
  - ElasticIP
  - ユーザーデータ
  - AMI
  - ALB
    - 無料ではないから悩ましい
    - でもBlue/Greenは経験しとくべきでは？
      - Team単位でならいいかも
  - TargetGroup
- Route53

#### RDS

#### Lambda

#### S3
- CodeDeploy使ったら、結局入っちゃいそうだな...

#### SNS

#### Cloud Formation


#### CloudWatch 
- Event
- Logs
- Dashboard (*)

#### CodePipeline (*)
- CodeCommit ... 使わないかも
- CodeBuild
- CodeDeploy
  - Inplaceデプロイ
  - Blue/Greenデプロイ
    - ※ALBは若干お高いので注意が必要

#### systems-manager (*)
- Session Manager
- Run Command
- パラメータストア

#### Cloud9 (*)
- ブラウザさえあれば使えるIDE
- 鍵回りとか
- ファイル閲覧も簡単