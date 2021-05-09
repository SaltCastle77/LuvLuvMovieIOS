# NotificationCenter

> 미리 등록된 observer 들에게 notifiaction을 전달하는 역할의 클래스

- *NotificationCenter에 등록된 Event가 발생하면 해당 Event들에 대한 행동을 취하는것.*
  *앱 내에서 아무데서나 메시지를 던지면 앱 내의 아무데서나 이 메시지를 받을 수 있게 해 주는 것이 NSNotificationCenter의 역활.*

```swift
override func viewDidLoad() {
        super.viewDidLoad()
        //시작할떄 notificationCenter를 가져와서 관찰자로 추가해준다.
        NotificationCenter.default.addObserver(self, selector: #selector(adjustButtonDynamicType), name: UIContentSizeCategory.didChangeNotification, object: nil)
}
```

- addObserver는 계속 탐지하는 거라고 보면되는데, name이 `UIContentSizeCategory.didChangeNotification` 로 들어올때 selector를 실행하라는 뜻이다.

