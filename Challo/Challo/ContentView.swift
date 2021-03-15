import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginPage(loginPresenter: LoginPresenter(
            interactor: LoginInteractor()
        ))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage(loginPresenter: LoginPresenter(
            interactor: LoginInteractor()
        ))
    }
}
