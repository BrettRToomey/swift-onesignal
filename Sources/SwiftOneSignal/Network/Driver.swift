import HTTP
import JSON

class NetworkDriver {
    enum Error: Swift.Error {
        case `internal`
        case apiKeyNotSet
        case appIDNotSet
        case requestError(value: String)
    }
    
    enum Endpoint: String {
        case sendNotification = "https://onesignal.com/api/v1/notifications"
    }
    
    var AUTH_HEADER: String {
        let apiKey = OneSignal.api_key!
        return "Basic \(apiKey)"
    }
    
    func send(_ notification: Notification) throws {
        guard OneSignal.api_key != nil else { throw Error.apiKeyNotSet }
        guard let appId = OneSignal.app_id else { throw Error.appIDNotSet }
        let endpoint = Endpoint.sendNotification
        
        var json = try JSON(node: [
            "app_id": appId,
            "contents": JSON(notification.message.makeNode()),
            "include_player_ids": JSON(notification.users.makeNode())
        ])
        
        if let subtitle = notification.subtitle {
            json["subtitle"] = JSON(try subtitle.makeNode())
        }
        
        if let contentAvailable = notification.isContentAvailable {
            json["content_available"] = JSON(contentAvailable.makeNode())
        }
        
        if let mutableContent = notification.isContentMutable {
            json["mutable_content"] = JSON(mutableContent.makeNode())
        }
        
        let data = try json.makeBytes()
        
        print(try data.toString())
        
        let result = try BasicClient.post(
            endpoint.rawValue,
            headers: [
                "Content-Type": "application/json",
                "Authorization": AUTH_HEADER
            ],
            body: Body.data(data)
        )
        
        print(result)
    }
}
