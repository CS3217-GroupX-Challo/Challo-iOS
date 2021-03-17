import SwiftUI

class LoginInteractor: InteractorProtocol {

    typealias JSON = AlamofireManager.JSON
    private let api = LoginAPI()

    weak var presenter: LoginPresenter!

    private var facebookLoginService = FacebookLoginService()

    init() {
        api.loginDelegate = self
        facebookLoginService.loginDelegate = self
    }

    func logInWithFacebook() {
        facebookLoginService.login()
    }

    func defaultLogin(email: String, password: String) {
        let json = createLoginJson(email: email, password: password)
        api.defaultLogin(credentials: json)
    }

    private func createLoginJson(email: String, password: String) -> JSON {
        var json = JSON()
        json["email"] = email
        json["password"] = password
        return json
    }
}

// MARK: Login Delegate
extension LoginInteractor: LoginDelegate {

    func loginProcessCompleted(loginResponse: LoginResponse) {
        guard let certificate = loginResponse.certificate, loginResponse.success else {
            self.presenter.showLoginFailureAlert()
            return
        }
        api.storeCertificate(certificate: certificate)
    }
}
