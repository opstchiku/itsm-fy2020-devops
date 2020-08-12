```mermaid
sequenceDiagram
    participant Customer
    participant Front
    participant (LB)
    participant API
    participant DB

    opt ヘルスチェック
        (LB)->>API: 現在時刻を取得
        API->>DB: 現在時刻を取得
        API->>API: (n秒 Wait ※課題用)
        API->>(LB): 
    end

    opt 会員登録する
        Customer->>Front: 名前とパスワードを入力
        Front-->>API: APIを実行
        API->>DB: 会員情報を登録
        alt 会員登録 OK
            DB-->>API: idを返却
            API-->>Front: idを返却
        else 会員登録 NG
            DB-->>API: ユニークキー違反
            DB->>DB: rollback
        end
    end

    opt ログインする
        Customer->>Front: 名前とパスワードを入力
        Front-->>API: APIを実行
        API->>DB: 情報を参照
        DB->>API: 
        alt ログイン OK
            API-->>Front: idとメッセージを返却
            Front-->>Customer: ログイン後コンテンツを表示
        else ログイン NG
            API-->>Front: 404エラーを返却
            Front-->>Customer: ログイン失敗ページを表示
        end
    end
```