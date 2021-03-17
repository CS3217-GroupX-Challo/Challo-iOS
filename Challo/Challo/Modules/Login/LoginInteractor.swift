import SwiftUI

class LoginInteractor: InteractorProtocol, LoginAPI {

    typealias JSON = AlamofireManager.JSON
    let api = AlamofireManager.alamofireManager
    weak var loginDelegate: LoginDelegate?
    let loginUrl = "/user/login"

    weak var presenter: LoginPresenter!

    private var facebookLoginService = FacebookLoginService()

    init() {
        facebookLoginService.loginDelegate = self
        self.loginDelegate = self
    }

    func logInWithFacebook() {
        facebookLoginService.login()
    }
}

// MARK: Login Delegate
extension LoginInteractor: LoginDelegate {

    func loginProcessCompleted(loginResponse: LoginResponse) {
        guard let certificate = loginResponse.certificate, loginResponse.success else {
            self.presenter.showLoginFailureAlert()
            return
        }
        self.storeCertificate(certificate: certificate)
    }
}
