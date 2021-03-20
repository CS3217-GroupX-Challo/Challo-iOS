import SwiftUI

struct ContentView: View {

    @EnvironmentObject var userState: UserState
    var (view, presenter) = MapModule.assemble()

    var body: some View {
        
        NavigationView { () -> AnyView in
            view
            /*
            if !userState.loggedIn {
                let (loginPage, _) = TouristLoginModule.assemble()
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
        let (loginPage, _) = GuideLoginModule.assemble()
        return loginPage
    }
}
