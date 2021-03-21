import Foundation

struct BlogPost {
    var title = ""
    var body = ""
    var author: UUID

    init(author: UserStateProtocol) {
        self.author = UUID(uuidString: author.userId) ?? UUID()
    }

    internal init(title: String, body: String, author: UUID) {
        self.title = title
        self.body = body
        self.author = author
    }

    var isValidTitle: Bool {
        !title.isEmptyOrOnlyWhiteSpace
    }

    var canBePublished: Bool {
        isValidTitle && !body.isEmptyOrOnlyWhiteSpace
    }
}

extension BlogPost: Equatable {
    // BlogPost members are all equatable
}
