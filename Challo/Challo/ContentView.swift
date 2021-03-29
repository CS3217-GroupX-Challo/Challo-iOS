import SwiftUI

struct ContentView: View {

    let userState: UserStateProtocol

    var MainContainer: some View {
        MainContainerModule.assemble(userState: userState).view
    }

    var body: some View {
        MainContainer
    }
}
