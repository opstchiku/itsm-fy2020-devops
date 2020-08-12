# 3. IaC
## アドバイス

## ハンズオン
### ansible
- サーバーの構成管理ツール
- 類似サービス
  - Chef
  - Puppet
  - SaltStack

### Cloud Formation
- AWS依存
- クラウド環境の構成管理ツール
  - ansibleより上のレイヤからコード化できる
    - どちらかを選ぶというより併用可能と捉えた方がよい
      - ansibleで作った環境をAMI化して、そのAMIを指定して構築するなど
        - ミドルウェアのインストールに時間がかかる場合などに有効

### その他類似サービス
## 注意点
- コード化するためには、まず概念の理解が必須
  - 構成図がイメージできないのにコード化はできない

0.014 per VPC Endpoint Hour