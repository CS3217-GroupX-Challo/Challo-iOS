import SwiftUI

struct Card<Content: View>: ContainerView {
    var content: () -> Content

    var body: some View {
        VStack{
            content()
        }
        .padding()
        .background(Color(red: 255 / 255,
                          green: 250 / 255,
                          blue: 250 / 255).opacity(0.8))
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            RegisterForm()
        }
    }
}
