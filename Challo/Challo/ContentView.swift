import SwiftUI

struct ContentView: View {
    var body: some View {
        let (loginPage, _) = LoginModule.assemble()
        return
            NavigationView {
                loginPage
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
