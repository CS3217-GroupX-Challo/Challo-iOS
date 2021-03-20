import Foundation

struct BlogPost {
    var title = ""
    var body = ""
    var author: UUID

    init(author: UserState) {
        guard let userID = UUID(uuidString: author.userId) else {
            self.author = UUID()
            return
        }
        self.author = userID
    }

    internal init(title: String, body: String, author: UUID) {
        self.title = title
        self.body = body
        self.author = author
    }

    var isValidTitle: Bool {
        title.range(of: "^\\S+", options: .regularExpression) != nil
    }
}
