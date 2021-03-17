import SwiftUI

struct ContentView: View {

    @EnvironmentObject var userState: UserState
    let (guidesListingPage, _) = GuidesModule.assemble()

    var body: some View {
        NavigationView { () -> AnyView in
            guidesListingPage
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
