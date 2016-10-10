import JSON

public struct Message: NodeRepresentable {
    private var messages: [String : String]
    
    init(_ message: String) {
        //English is required by `OneSignal`
        messages = ["en": message]
    }
    
    public func makeNode(context: Context) throws -> Node {
        var object = Node.object([:])
        messages.forEach {
            object[$0] = $1.makeNode()
        }
        return object
    }
    
    subscript(key: String) -> String? {
        get {
            return messages[key]
        }
        
        set {
            messages[key] = newValue
        }
    }
}

public struct Notification {
    var users: [String]
    
    var message: Message
    var subtitle: Message? //iOS 10+
    
    var isContentAvailable: Bool? //iOS
    var isContentMutable: Bool? //iOS 10+
    
    init(message: String) {
        self.message = Message(message)
        users = []
    }
    
    init(message: Message) {
        self.message = message
        users = []
    }
    
    init(message: String, users: [String]) {
        self.message = Message(message)
        self.users = users
    }
    
    init (message: Message, users: [String]) {
        self.message = message
        self.users = users
    }
}

extension Notification {
    mutating func addUser(_ id: String) {
        users.append(id)
    }
    
    mutating func addMessage(_ message: String, language: String = "en") {
        self.message[language] = message
    }
}

extension Notification {
    //English only
    mutating func setSubtitle(_ subtitle: String) {
        let message = Message(subtitle)
        setSubtitle(message)
    }
    
    mutating func setSubtitle(_ message: Message) {
        self.subtitle = message
    }
    
    //TODO(Brett): add check to make `content` nil-able if `isContentAvailable`
    //in order to allow silent notifications on iOS
    mutating func setContentAvailable(_ isContentAvailable: Bool) {
        self.isContentAvailable = isContentAvailable
    }
    
    mutating func setContentMutability(_ isContentMutable: Bool) {
        self.isContentMutable = isContentMutable
    }
}












