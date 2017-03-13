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

```
tracker = GAI.sharedInstance().defaultTracker!
tracker.set(kGAIScreenName, value: "スクリーン名を記述")
tracker.send(GAIDictionaryBuilder.createScreenView().build() as [NSObject: AnyObject])
tracker.set(kGAIScreenName, value: nil)
```

### イベントのトラッキング
```
let build = 
    GAIDictionaryBuilder.createEvent(withCategory: "カテゴリ名を記載",action: "アクション名を記載",label: "ラベルを記載",value: 1).build() as [NSObject : AnyObject]
tracker?.send(build)
```
