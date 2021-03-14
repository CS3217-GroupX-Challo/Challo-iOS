import SwiftUI

struct Card<Content: View>: ContainerView {
    var content: () -> Content

    var body: some View {
        VStack{
            content()
        }
        .padding()
        .background(Color(red: 240,
                          green: 240,
                          blue: 240).opacity(0.8))
    }
}

struct Card_Previews: PreviewProvider {
    static var previews: some View {
        Card {
            RegisterForm()
        }
    }
}
