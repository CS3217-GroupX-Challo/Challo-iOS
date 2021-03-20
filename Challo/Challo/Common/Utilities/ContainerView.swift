import SwiftUI

protocol ContainerView: View {
    associatedtype Content
    init(content: @escaping () -> Content)
}

extension ContainerView {
    var id: UUID {
        UUID()
    }
    
    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.init(content: content)
    }
}
