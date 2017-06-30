# ios-googleanalytics-demo
iOS Google Analytics を利用したサンプルです。

## 1. PodFile

```
pod ‘Google/Analytics’
```

## 2. 設定ファイルを取得する

https://developers.google.com/analytics/devguides/collection/ios/v3/?ver=swift&hl=ja#get-config<br>
プロジェクトのルートに取得した GoogleService-Info.plist を配置する<br>

## 3. Bridging-Headerを作成する
Bridging-Headerを作成して以下を記述する<br>

```
#import <GoogleAnalytics/GAI.h>
#import <GoogleAnalytics/GAIFields.h>
#import <GoogleAnalytics/GAILogger.h>
#import <GoogleAnalytics/GAITracker.h>
#import <GoogleAnalytics/GAIDictionaryBuilder.h>
```

## 4. AppDelegateで初期化する

```
let gai = GAI.sharedInstance()!
gai.trackUncaughtExceptions = true

if let path = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") {
    if let propertyList = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
        let trackingId = propertyList["TRACKING_ID"] as! String
        gai.tracker(withTrackingId: trackingId)
    }
}
```

## 5. トラッキングする
トラッキングする箇所にコードを埋め込む

### スクリーンのトラッキング
実装ファイルの viewWillAppear 内でスクリーントラッキングを行います。

```
tracker = GAI.sharedInstance().defaultTracker!
tracker.set(kGAIScreenName, value: "スクリーン名を記述")
tracker.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject: AnyObject])
tracker.set(kGAIScreenName, value: nil)
```

### イベントのトラッキング
例えばボタンをタップした際などにイベントトラッキングを行います。
指定できるのは「カテゴリ」「アクション」「ラベル」「値」「スクリーン名」の 5つで、詳細を正確に指定することにより、コンバージョンの設定が容易になります。

```
let build = 
    GAIDictionaryBuilder.createEvent(withCategory: "カテゴリ名を記載",action: "アクション名を記載",label: "ラベルを記載",value: 1).build() as [NSObject : AnyObject]
tracker?.send(build)
```

## 参考
### Google公式
- [iOS 向けアナリティクスを試してみる](https://developers.google.com/analytics/devguides/collection/ios/v3/start?ver=swift&hl=ja)
- [iOS アプリにアナリティクスを追加する](https://developers.google.com/analytics/devguides/collection/ios/v3/?ver=swift&hl=ja)

### その他
- [iOSアプリへの Google Analytics 導入方法](https://lab.dolice.net/blog/2015/06/26/ios-google-analytics/)
- [[iOS]Google Analytics iOS #1 ページビューを計測する](http://dev.classmethod.jp/smartphone/iphone/google-analytics-for-ios-1/)
- [Swift版iOSアプリをGoogleアナリティクスで計測する手順(v3.15)](http://2m3g1.com/3149.html)
- [iOS版GoogleAnalyticsを利用](http://qiita.com/ysk_1031/items/245ff929ea76f0eda11d)