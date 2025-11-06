# Aimstar In App Log iOS SDK

## Requirements

ランタイム: iOS 16以上をサポート

開発環境: Xcode 16.4 on macOS Sequoia 15.3

## 制限事項

- マルチウインドウ構成のアプリには対応していません
- SwiftUI ベースのアプリでの動作は未検証のため、UIKit を推奨します

## SDKで提供する機能について

- ページ閲覧イベントをはじめとした、ユーザーのアプリ操作イベントを Aimstar に送信する
- ログイン・ログアウト状態を管理し、ユーザー単位でログを紐づける
- バッチ送信間隔や一度に送信するログの件数上限など、ログ送信の挙動を設定する

## 用語

| 用語 | 説明 |
| --- | --- |
| API Key | Aimstar In App Log を利用するために必要な API キーで、Aimstar 側で事前にアプリ開発者に発行されます。 |
| Tenant ID | Aimstar In App Log を利用するために必要なテナント ID で、Aimstar 側で事前にアプリ開発者に発行されます。 |
| Batch Interval | Aimstar In App Log では、アプリ開発者がログを送信する「間隔」（秒単位）を指定できます。 |
| Max Batch Count |  Aimstar In App Log では、アプリ開発者が一度に送信するログの「件数上限」を指定できます。 |
| Customer ID | アプリ開発者がユーザーを識別する ID で、アプリ開発者が独自に発行、生成、または利用します。 |
| Session ID |  Aimstar In App Log 側で、アプリ起動ごとに新規発行するセッション識別子です。 |
| Installation ID | Aimstar In App Log 側で、アプリインストールごとに一意となる識別子です。 |

## 導入手順

### 1.SDKをアプリに追加する

#### CocoaPodsを利用する場合

`Podfile` に以下を追記し、`pod install` を実行してください。

```ruby
pod "AimstarInAppLog"
```

#### 手動で追加する場合

1. [Releases](https://github.com/supsysjp/aimstar-in-app-log-ios/releases) から `AimstarInAppLogSDK.zip` をダウンロードして展開し、  `AimstarInAppLogSDK.xcframework` を準備してください。
2. プロジェクトの設定画面で「**General**」タブを開きます。
3. **Frameworks, Libraries, and Embedded Content** に `.xcframework` を追加します。
4. 「Embed & Sign」を選択します。
5. プロジェクトの設定画面で「Build Phases」 > 「Link Binary With Libraries」に `AimstarInAppLogSDK.xcframework` が追加されていることを確認してください。

### 2.SDKの初期化を行う

`application(_:didFinishLaunchingWithOptions:)` メソッド内で初期化を行います。

```swift
import AimstarInAppLogSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let config = AimstarLogSDKConfig(apiKey: "Your API Key", tenantId: "Your Tenant ID")

        // 必要に応じてログの送信に関する設定を行います
        //config.batchInterval = 20
        //config.maxBatchCount = 50

        // SDKの初期化
        AimstarInAppLog.shared.setup(config: config)
        return true
    }
}
```

### 3. Batch Interval と Max Batch Countの設定

setup時に必要に応じてログの送信に関する設定をしてください。

```swift
let config = AimstarLogSDKConfig(apiKey: apiKey, tenantId: tenantId)

// ログを送信する「間隔」（秒単位）を指定できます。
config.batchInterval = 20

// 一度に送信するログの「件数上限」を指定できます。
config.maxBatchCount = 50
```

### 4.Customer IDの設定

ユーザーの識別が可能になった段階で Customer ID を設定します。ログアウト時は `nil` を設定してください。

```swift
// ログイン直後など、ユーザーが識別できる状態で実行
AimstarInAppLog.shared.updateLoginState(customerId: "user_001")

// ログアウト時
AimstarInAppLog.shared.updateLoginState(customerId: nil)
```

### 5.ユーザー操作イベントの記録

スクリーン名やイベント名を指定してログを送出します。バッチ設定に従って Aimstar に送信されます。

```swift
// 例：ページ閲覧イベントの送出
AimstarInAppLog.shared.trackPageView(
    pageUrl: "http//...",
    pageTitle: self.title,
    referrerUrl: "http//...",
    customParams: [
        "is_logged_in": .bool(true),
        "membership_level": .string("gold")
    ]
)
```

# SDK References

## AimstarLogSDKConfig

```swift
struct AimstarLogSDKConfig
```

SDK 初期化時の設定を管理する構造体です。必須項目としてAPI Key・Tenant ID、オプション項目としてBatch Interval・Max Batch Countを指定します。

### Properties

#### batchInterval: Int?

```swift
var batchInterval: Int?
```

Aimstar へログイベントをバッチ送信する「間隔」（秒）を設定します。

#### maxBatchCount: Int?

```swift
var maxBatchCount: Int?
```

Aimstar へ一度に送信するログイベントの「件数上限」を指定します。

## AimstarInAppLog

```swift
class AimstarInAppLog
```

SDK のエントリーポイントです。`setup` メソッドを通じて初期化を行います。初期化が完了するまでイベント送出は利用できません。

### Properties

#### shared: AimstarInAppLog

```swift
static let shared: AimstarInAppLog
```

シングルトンインスタンスです。

#### sessionId: String?

```swift
var sessionId: String?
```

アプリ起動ごとに新規発行されるセッションIDを参照できます。

#### installationId: String?

```swift
var installationId: String?
```

アプリインストールごとに一意となるIDを参照できます。

### Functions

#### setup(config:)

```swift
func setup(config: AimstarLogSDKConfig)
```

SDK の初期化を行います。

#### updateLoginState(customerId:)

```swift
func updateLoginState(customerId: String?)
```

ユーザーのログイン状態を更新します。`nil` を渡すとログアウト状態になります。

#### updateDeepLink(campaign:, content:, medium:, source:, term:)

```swift
func updateDeepLink(
    campaign: String? = nil,
    content: String? = nil,
    medium: String? = nil,
    source: String? = nil,
    term: String? = nil
)
```

Deep Link情報を更新します。

#### trackPageView(pageUrl:, pageTitle:, referrerUrl:, customParams:)

```swift
func trackPageView(
    pageUrl: String?,
    pageTitle: String?,
    referrerUrl: String?,
    customParams: [String: CustomValue]? = nil
)
```

ページ閲覧イベントを Aimstar に送信します。

#### trackProductInfo(brand:, productCategory:, productId:, productName:, productPrice:, skuId:, customParams:)

```swift
func trackProductInfo(
    brand: String?,
    productCategory: String?,
    productId: String?,
    productName: String?,
    productPrice: Double?,
    skuId: String?,
    customParams: [String: CustomValue]? = nil
)
```

商品情報閲覧イベントを Aimstar に送信します。

#### trackClickButton(action:, buttonId:, buttonName:, buttonText:, customParams:)

```swift
func trackClickButton(
    action: String? = nil,
    buttonId: String? = nil,
    buttonName: String? = nil,
    buttonText: String? = nil,
    customParams: [String: CustomValue]? = nil
)
```

ボタンクリックイベントを Aimstar に送信します。

#### trackSearch(pageNumber:, requestUrl:, resultsCount:, searchQuery:, searchType:, sortKey:, sortOrder:, statusCode:, customParams:)

```swift
func trackSearch(
    pageNumber: Int? = nil,
    requestUrl: String? = nil,
    resultsCount: Int? = nil,
    searchQuery: String? = nil,
    searchType: String? = nil,
    sortKey: String? = nil,
    sortOrder: String? = nil,
    statusCode: Int? = nil,
    customParams: [String: CustomValue]? = nil
)
```

検索行動イベントを Aimstar に送信します。

#### trackCartProduct(amount:, cartId:, productId:, productName:, skuId:, customParams:)

```swift
func trackCartProduct(
    amount: Int? = nil,
    cartId: String? = nil,
    productId: String? = nil,
    productName: String? = nil,
    skuId: String? = nil,
    customParams: [String: CustomValue]? = nil
)
```

カート操作イベントを Aimstar に送信します。

#### trackFavoriteProduct(isUnfavorite:, productId:, productName:, skuId:, customParams:)

```swift
func trackFavoriteProduct(
    isUnfavorite: Bool? = nil,
    productId: String? = nil,
    productName: String? = nil,
    skuId: String? = nil,
    customParams: [String: CustomValue]? = nil
)
```

お気に入り操作イベントを Aimstar に送信します。

#### trackPurchase(cartId:, itemCount:, orderId:, paymentMethod:, shippingAmount:, taxAmount:, totalAmount:, customParams:)

```swift
func trackPurchase(
    cartId: String? = nil,
    itemCount: Int? = nil,
    orderId: String? = nil,
    paymentMethod: String? = nil,
    shippingAmount: Double? = nil,
    taxAmount: Double? = nil,
    totalAmount: Double? = nil,
    customParams: [String: CustomValue]? = nil
)
```

購入完了イベントを Aimstar に送信します。

#### trackPushLog(notificationId:, notificationAction:, customParams:)

```swift
func trackPushLog(
    notificationId: String? = nil,
    notificationAction: String? = nil,
    customParams: [String: CustomValue]? = nil
)
```

プッシュ通知イベントを Aimstar に送信します。

#### trackRequestApi(latencyMs:, errorMessage:, queryParams:, requestMethod:, requestOrigin:, requestSize:, requestUrl:, statusCode:, customParams:)

```swift
func trackRequestApi(
    latencyMs: Int? = nil,
    errorMessage: String? = nil,
    queryParams: String? = nil,
    requestMethod: String? = nil,
    requestOrigin: String? = nil,
    requestSize: Int? = nil,
    requestUrl: String? = nil,
    statusCode: Int? = nil,
    customParams: [String: CustomValue]? = nil
)
```

外部API呼び出しイベントを Aimstar に送信します。

## Exampleプロジェクト

リポジトリ内の `Example/AimstarInAppLog.xcodeproj` にサンプルアプリを同梱しています。初期化やイベント送出の動作確認にご活用ください。
