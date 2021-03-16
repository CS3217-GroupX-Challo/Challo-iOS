import SwiftUI

struct ContentView: View {

    @EnvironmentObject var userState: UserState

    var body: some View {
        NavigationView { () -> AnyView in
            AnyView(GuidesListingPage())
            /*
            if !userState.loggedIn {
                let (loginPage, _) = LoginModule.assemble()
                return loginPage
            } else {
                return AnyView(Text("MOCK HOMEPAGE"))
            }*/
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let (loginPage, _) = LoginModule.assemble()
        return loginPage
    }
}
