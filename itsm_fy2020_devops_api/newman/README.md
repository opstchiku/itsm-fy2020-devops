# postman を使用してAPIテストを実施する

## 環境の準備

- postmanをインストールしておく

## APIテストで使用する各種ファイルの説明
### collection

|対象API|collectionファイル名|collection名|
|---|---|---|
|adminAPI|voucher_manual_testing.admin.postman_collection.json|VoucherAdminAPI|
|serviceAPI|voucher_manual_testing.service.postman_collection.json|VoucherServiceAPIリリース時動作確認|
|serviceAPI(参照系のみ)|voucher_manual_testing.service_readonly.postman_collection.json|VoucherServiceAPIリリース時動作確認(参照のみ)|
|serviceAPI(Runner対象外)|voucher_manual_testing_no_runner.service.postman_collection.json|VoucherServiceAPIリリース時動作確認対象外|

### environment

|環境|environmentファイル名|更新系実行可否|
|---|---|---|
|localhost|API_00-localhost-54251.postman_environment.json|○|
|team-develop|API_10-teamdevelop-webapi.ebook-voucher.be.postman_environment.json|○|
|team-master|API_11-teammaster-webapi.ebook-voucher.be.postman_environment.json|○|
|team-pr|API_12-teampr-webapi.ebook-voucher.be.postman_environment.json|○|
|jp-dev|API_96-dev-webapi.ebookjapan.jp.postman_environment.json|○|
|jp-stg|API_97-stg-webapi.ebookjapan.jp.postman_environment.json|○|
|jp-prev|API_98-prev-webapi.ebookjapan.jp.postman_environment.json|×|
|jp-prod|API_99-prod-webapi.ebookjapan.jp.postman_environment.json|×|

### environmentで定義している環境変数
- domain
  - プロトコル部分(https://～ )から記載
  - 末尾はスラッシュ(/)不要
- uuid
  - 255文字以内
  - (運用上は半角数字0～9と、半角英字A～Fの48桁で構成される想定/英字部分は大文字)

### collection `VoucherAdminAPI` 内で動的に生成される環境変数
- Runnerで実行した場合、Postman側のenvironmentには反映されないため注意

|パラメータ|生成タイミング|設定内容|
|---|---|---|
|__coin_operation_id|コイン発行申請 実行後|レスポンスのcoin_operation_id|
|__coupon_master_id_first|クーポンマスタ登録API(初回限定クーポン登録) 実行後|レスポンスのcoupon_master_id|
|__coupon_master_id|クーポンマスタ登録API(通常クーポン登録) 実行後|レスポンスのcoupon_master_id|
|__stocked_coupon_id|所有クーポン参照API (Collection Runner用サービスAPI) 実行後|レスポンスのcoupon_master_idが、環境変数 `coupon_master_id` に一致する最初のクーポンのstocked_coupon_id|
|__coupon_master_id_print|印刷クーポン登録API 実行後|レスポンスのcoupon_master_id|

### collection `VoucherServiceAPIリリース時動作確認` 内で動的に生成される環境変数
- Runnerで実行した場合、Postman側のenvironmentには反映されないため注意

|パラメータ|生成タイミング|設定内容|
|---|---|---|
|__external-id|動的変数セット (with クーポンマスター同期データ参照) 実行前|external-【現在日時のYYYYMMDDhhmmss】|
|__uuid|動的変数セット (with クーポンマスター同期データ参照) 実行前|uuid-【現在日時のYYYYMMDDhhmmss】|
|__non_login_uuid|動的変数セット (with クーポンマスター同期データ参照) 実行前|non_login_uuid-【現在日時のYYYYMMDDhhmmss】|
|__order_id|動的変数セット (with クーポンマスター同期データ参照) 実行前|order-【現在日時のYYYYMMDDhhmmss】|
|__order_datetime|動的変数セット (with クーポンマスター同期データ参照) 実行前|現在日時を `YYYY-MM-DDT00:00:00+09:00` でフォーマット|
|__usable_period_start_datetime|動的変数セット (with クーポンマスター同期データ参照) 実行前| `2018-04-01T00:00:00+09:00` 固定|
|__usable_period_end_datetime|動的変数セット (with クーポンマスター同期データ参照) 実行前|現在日時+3日後を `YYYY-MM-DDT00:00:00+09:00` でフォーマット|
|__stockable_start_datetime|動的変数セット (with クーポンマスター同期データ参照) 実行前|`2018-03-01T00:00:00+09:00` 固定|
|__stockable_end_datetime|動的変数セット (with クーポンマスター同期データ参照) 実行前|現在日時+1日後を `YYYY-MM-DDT00:00:00+09:00` でフォーマット|
|__sync_coupon_mode|動的変数セット (with クーポンマスター同期データ参照) 実行後|レスポンスのsync_coupon_mode|
|__coupon_master_id|01_クーポンマスタ登録API(通常クーポン登録) 実行後|レスポンスのcoupon_master_id|
|__stocked_coupon_id|06_クーポンストックAPI 実行後|レスポンスのstocked_coupon_id|
|__coupon_master_id_print|11_印刷クーポン登録API 実行後|レスポンスのcoupon_master_id|
|key_code|12_印刷クーポン入稿データ取得API 実行後|レスポンス2件目のkey_code|

### collection `VoucherServiceAPIリリース時動作確認(参照のみ)` 内で動的に生成される環境変数

|パラメータ|生成タイミング|設定内容|
|---|---|---|
|なし| | |

### collection `VoucherServiceAPIリリース時動作確認対象外` 内で動的に生成される環境変数

|パラメータ|生成タイミング|設定内容|
|---|---|---|
|なし| | |

### jp環境のEnvironmentについて

- 以下の環境においては、更新系の実行は不可能であるため、`VoucherServiceAPIリリース時動作確認(参照のみ)` を実行可能とする
  - jp-prev, jp-prod
  - `no1api-voucher/test/newman/collection/voucher_manual_testing.service_readonly.postman_collection.json` のみ使用可能

### UUIDについて

- jp-prev, jp-prodでは更新系を実行できないため、既に実在しているUUIDを使用する必要がある
- 上記環境で使用可能なUUIDについては、voucherメンバーの誰かに問い合わせること

## テストの実行（GUI）

### 初回実行時のみ
1. 画面左上の `Import` ボタンから、collectionファイルをインポートする
![collectionのimport](images/01.png)
2. 画面右上の 歯車ボタンからMANAGE ENVIRONMENTSを開き、下部の `Import` ボタンから、environmentファイルをインポートする
![environmentのimport](images/02.png)
![MANAGE ENVIRONMENTS](images/03.png)

### Collectionのテスト実施
1. 以下のいずれかの方法で、Collection Runnerを起動する
- 画面左上の `Runner` ボタン
![画面上部から](images/04.png)
- テストしたいCollectionを選択した後に表示される `Run` ボタン  
※こちらの方法でCollection Runnerを起動した場合、その時選択していたCollectionとEnvironmentが選択された状態で起動します
![Collectionから](images/05.png)
2. テストしたいCollectionとEnvironmentを選択する  
`実際にAPIを叩いて実データの更新が走るテストのため、テスト実施環境は要確認`
![CollectionとEnvironmentを選択](images/06.png)
3. 画面左下の `Run {選択したCollection名}` ボタンをクリックして、テストを実行する
![テスト実行](images/07.png)
4. 実行結果が表示される
![テスト実行結果](images/08.png)

## テストの実行（CLI）

### 前提条件

node及びnpmが利用可能であること  
動作を保証するバージョンは以下  

- node : 10.20.x
- npm : 6.x.x


### 事前準備

1. このディレクトリに、Powershell、git-bash等のコンソールで移動する
2. 以下のコマンドで、必要なライブラリをインストールする
```
> npm ci
```

※ `npm install` ではなく `npm ci` を使うことで環境を `package-lock.json` の内容に固定する  
※ ライブラリの更新等を行う場合は、`npm install`にてインストールし、`package-lock.json` を更新すること  

#### jp-prev、jp-prodで試験を行う場合

jp-prev、jp-prodの実行は、データの更新ができないため登録済みのUUID、External-IDが必要である

1. `.env`ファイルが無ければ作成する ※ `env.sample`をコピーしてもよい
2. ファイル中に以下のキー値を記述する
  - `prev_uuid`
  - `prev_non_login_uuid`
  - `prev_external_id`
  - `prod_uuid`
  - `prod_non_login_uuid`
  - `prod_external_id`

なお、このファイルはGitへは登録されない

#### 結果をgitHubへ投稿する場合

1. GitHubにて `Personal access token` を取得する
  - 権限スコープは `repo` を指定する
2. `.env`ファイルが無ければ作成する ※ `env.sample`をコピーしてもよい
3. 取得したトークン文字列を、キー`access_token`に記述する

※ 取得したトークン文字列は、再取得できないので注意

なお、このファイルはGitへは登録されない

### テストの実行のみ行う

1. このディレクトリに、Powershell、git-bash等のコンソールで移動する
2. 以下のコマンドを実行する
```
> npm run {環境名}
```
  - 環境名は次のいずれか [ local | team-dev | team-pr | team-master | jp-dev | jp-stg | jp-prev | jp-prod ]

### テストを実行し、結果をgitHubへ投稿

1. このディレクトリに、Powershell、git-bash等のコンソールで移動する
2. 以下のコマンドを実行する
```
> npm run {環境名} -- -i {issue番号 | PR番号}
```
  - 環境名は次のいずれか [ local | team-dev | team-pr | team-master | jp-dev | jp-stg | jp-prev | jp-prod ]
  - issue番号、PR番号は `#` 抜きの数字のみ指定すること
3. 投稿予定のissue名またはPR名が表示されるので、問題なければ `y` を入力しエンターキー押下
4. 実行したくなければ、`y` 以外を入力するか、何も入力しないでエンターキー押下にて終了する

### コードビルド等自動実行用パラメータ

他のシェルやスクリプト等から呼び出す場合は、以下のパラメータを指定することができる
```
> npm run {環境名} -- -c true
```
指定した場合は、確認のプロンプトが表示されない。
また、実行環境とテスト対象が同じ環境である前提で動作する。