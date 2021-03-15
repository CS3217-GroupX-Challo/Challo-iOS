import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LoginPage(loginPresenter: LoginPresenter(
                interactor: LoginInteractor()
            ))
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(loginPresenter: LoginPresenter(
            interactor: LoginInteractor()
        ))
    }
}
