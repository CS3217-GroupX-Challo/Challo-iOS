import SwiftUI

struct Card<Content: View>: ContainerView {
    var content: () -> Content

    var body: some View {
        VStack {
            content()
        }
        .padding()
        .background(Color.themeBackground
                        .opacity(0.95))
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            Text("Hello!")
        }
    }
}
