public class OneSignal {
    private init() {}
    
    public static var api_key: String?
    public static let instance = OneSignal()
    
    let driver = NetworkDriver()
    
    public func send(notification: Notification) throws {
        try driver.send(notification)
    }
}
