import SwiftUI

class LoginInteractor: InteractorProtocol {

    weak var presenter: LoginPresenter!

    @AppStorage("logged_in") var loggedIn = false
    @AppStorage("email") var email = ""
    @AppStorage("name") var name = ""
    @AppStorage("token") var token = ""

    private var facebookLoginService = FacebookLoginService()

    init() {
        facebookLoginService.loginDelegate = self
    }

    func logInWithFacebook() {
        facebookLoginService.login()
    }
}

// MARK: Login Delegate
extension LoginInteractor: LoginDelegate {

    func loginProcessCompleted(loginResponse: LoginResponse) {
        self.storeLoginResponse(response: loginResponse)
        print("LOGGED IN: \(loggedIn)")
        print("EMAIL: \(email)")
        print("NAME: \(name)")
        print("TOKEN: \(token)")
    }

    private func storeLoginResponse(response: LoginResponse) {
        loggedIn = response.success
        email = response.email ?? ""
        name = response.name ?? ""
        token = response.token ?? ""
    }
}
