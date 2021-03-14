import SwiftUI
import FBSDKLoginKit

struct ContentView: View {
    var body: some View {
        WelcomePage(interactor: WelcomeInteractor())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage(interactor: WelcomeInteractor())
    }
}
