import SwiftUI

struct ContentView: View {

    let userState: UserStateProtocol

    var MainContainer: some View {
        MainContainerModule(userState: userState).assemble().view
    }

    var body: some View {
        MainContainer
    }
}
