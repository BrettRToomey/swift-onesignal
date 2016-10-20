import JSON

public struct Message: NodeRepresentable {
    private var messages: [String : String]
    
    public init(_ message: String) {
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
    public var users: [String]
    
    public var message: Message
    public var title: Message?
    public var subtitle: Message? //iOS 10+
    
    public var isContentAvailable: Bool? //iOS
    public var isContentMutable: Bool? //iOS 10+
    
    public init(message: String) {
        self.message = Message(message)
        users = []
    }
    
    public init(message: Message) {
        self.message = message
        users = []
    }
    
    public init(message: String, users: [String]) {
        self.message = Message(message)
        self.users = users
    }
    
    public init (message: Message, users: [String]) {
        self.message = message
        self.users = users
    }
}

extension Notification {
    public mutating func addUser(_ id: String) {
        users.append(id)
    }
    
    public mutating func addMessage(_ message: String, language: String = "en") {
        self.message[language] = message
    }
}

extension Notification {
    //English only
    
    public mutating func setTitle(_ title: String) {
        let message = Message(title)
        setTitle(message)
    }
    public mutating func setTitle(_ message: Message) {
        self.title = message
    }
    
    
    public mutating func setSubtitle(_ subtitle: String) {
        let message = Message(subtitle)
        setSubtitle(message)
    }
    
    public mutating func setSubtitle(_ message: Message) {
        self.subtitle = message
    }
    
    //TODO(Brett): add check to make `content` nil-able if `isContentAvailable`
    //in order to allow silent notifications on iOS
    public mutating func setContentAvailable(_ isContentAvailable: Bool) {
        self.isContentAvailable = isContentAvailable
    }
    
    public mutating func setContentMutability(_ isContentMutable: Bool) {
        self.isContentMutable = isContentMutable
    }
}












