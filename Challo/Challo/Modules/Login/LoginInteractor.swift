import SwiftUI

class LoginInteractor: InteractorProtocol, LoginAPI {

    let networkManager = AlamofireManager.alamofireManager
    let loginUrl = "/user/login"
    weak var presenter: LoginPresenter!

    private var facebookLoginService = FacebookLoginService()

    init() {
        facebookLoginService.loginDelegate = self
    }

    func logInWithFacebook() {
        facebookLoginService.login()
    }

    func defaultLogin(email: String, password: String) {
        let json = createLoginJson(email: email, password: password)
        self.commonLogin(credentials: json, callback: { response in
            self.loginProcessCompleted(response: response)
        })
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

    func loginProcessCompleted(response: UserAPIResponse) {
        guard let certificate = response.certificate, response.success else {
            self.presenter.showLoginFailureAlert()
            return
        }
        self.storeCertificate(certificate: certificate)
    }
}
