import SwiftUI

struct ContentView: View {

    var MainContainer: some View {
        MainContainerModule.assemble().view
    }

    var body: some View {
        BlogWriterModule.assemble().view
    }
}
