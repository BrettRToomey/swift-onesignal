public struct Notification {
    var users: [String]
    let message: String
    
    init(message: String) {
        self.message = message
        users = []
    }
    
    init(message: String, users: [String]) {
        self.message = message
        self.users = users
    }
}

extension Notification {
    mutating func addUser(_ id: String) {
        users.append(id)
    }
}
