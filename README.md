# Aimstar In App Log SDK

## Requirements

ランタイム: iOS 16以上をサポート
開発環境: Xcode 15.2 on macOS 14.2.1

## 制限事項

- マルチウインドウ構成のアプリには対応していません
- SwiftUI ベースのアプリでの動作は未検証のため、UIKit を推奨します
<!-- - 短時間に大量のイベントを送出する場合は、排他制御やバッチ設定を調整してください -->

## SDKで提供する機能について

- アプリのページ閲覧イベントやカスタムイベントを Aimstar に送信する
- ログイン・ログアウト状態を管理し、ユーザー単位でログを紐づける
- バッチ送信間隔やイベント数など、ログ送信の挙動を設定する

## 用語

| 用語 | 説明 |
| --- | --- |
| API Key | Aimstar In App Log を利用するために必要な API キーで、Aimstar 側で事前にアプリ開発者に発行されます。 |
| Tenant ID | Aimstar In App Log を利用するために必要なテナント ID で、Aimstar 側で事前にアプリ開発者に発行されます。 |
| Customer ID | アプリ開発者がユーザーを識別する ID で、アプリ開発者が独自に発行、生成、または利用します。 |

## 導入手順

### 1.SDKをアプリに追加する

#### CocoaPodsを利用する場合

`Podfile` に以下を追記し、`pod install` を実行してください。

```ruby
pod "AimstarInAppLog"
```

#### 手動で追加する場合

[releases](https://github.com/supsysjp/aimstar-in-app-log-ios/releases) から `AimstarInAppLogSDK.zip` をダウンロードして展開し、`AimstarInAppLogSDK.xcframework` をプロジェクトに追加してください。

### 2.SDKの初期化を行う

`application(_:didFinishLaunchingWithOptions:)` メソッド内で初期化を行います。

```swift
import AimstarInAppLog

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let API_KEY = "Your API KEY"
        let TENANT_ID = "Your TENANT ID"

        AimstarInAppLog.shared.setup(apiKey: API_KEY, tenantId: TENANT_ID)
        return true
    }
}
```

### 3.Customer IDの設定

ユーザーの識別が可能になった段階で Customer ID を設定します。ログアウト時は `nil` を設定してください。

```swift
// ログイン直後など、ユーザーが識別できる状態で実行
AimstarInAppLog.shared.updateLoginState(customerId: "user_001")

// ログアウト時
AimstarInAppLog.shared.updateLoginState(customerId: nil)
```

### 4.ページ閲覧イベントの送出

スクリーン名やイベント名を指定してログを送出します。バッチ設定に従って Aimstar に送信されます。

```swift
// ページ閲覧イベントの送出
AimstarInAppLog.shared.trackPageView(screenName: "Home")
```

---

# SDK References

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

### Functions

#### setup(apiKey: String, tenantId: String)

```swift
func setup(apiKey: String, tenantId: String)
```

SDK の初期化を行います。

#### updateLoginState(customerId: String?)

```swift
func updateLoginState(customerId: String?)
```

ユーザーのログイン状態を更新します。`nil` を渡すとログアウト状態になります。

#### trackPageView(screenName: String)

```swift
func trackPageView(screenName: String)
```

ページ閲覧イベントを Aimstar に送信します。

---

## Exampleプロジェクト

リポジトリ内の `Example/AimstarInAppLog.xcodeproj` にサンプルアプリを同梱しています。初期化やイベント送出の動作確認にご活用ください。
