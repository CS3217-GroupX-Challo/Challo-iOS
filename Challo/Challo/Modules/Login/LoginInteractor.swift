import SwiftUI

class LoginInteractor: InteractorProtocol, UserAPIInteractor {

    typealias JSON = AlamofireManager.JSON
    let api = AlamofireManager.alamofireManager
    private let loginUrl = "/user/login"

    weak var presenter: LoginPresenter!

    @AppStorage("logged_in") var loggedIn = false
    @AppStorage("email") var email = ""
    @AppStorage("name") var name = ""
    @AppStorage("token") var token = ""
    @AppStorage("userId") var userId = ""

    private var facebookLoginService = FacebookLoginService()

    init() {
        facebookLoginService.loginDelegate = self
    }

    func logInWithFacebook() {
        facebookLoginService.login()
    }

    func defaultLogin(email: String, password: String) {
        let json = createLoginJson(email: email, password: password)
        api.post(url: loginUrl,
                 headers: AlamofireManager.HEADER(),
                 body: json) { res, err in
            if let err = err {
                print("Error: \(err)")
                self.presenter.showLoginFailureAlert()
                return
            }
            let parsed = self.parseUser(apiResponse: res)
            guard let certificate = parsed else {
                self.presenter.showLoginFailureAlert()
                return
            }
            self.loginProcessCompleted(loginResponse: LoginResponse(success: true, certificate: certificate))
        }
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
            return
        }
        self.storeCertificate(certificate: certificate)
        print("LOGGED IN: \(loggedIn)")
        print("NAME: \(name)")
        print("EMAIL: \(email)")
        print("TOKEN: \(token)")
        print("USERID: \(userId)")
    }
}
