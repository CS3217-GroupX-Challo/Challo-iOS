import SwiftUI

protocol LoginInteractor: LoginAPI, LoginDelegate {

    var presenter: LoginPresenter! { get set }
    var facebookLoginService: FacebookLoginService { get }

    func logInWithFacebook()
    func defaultLogin(email: String, password: String)
}

extension LoginInteractor {

    func logInWithFacebook() {
        facebookLoginService.login()
    }

    func defaultLogin(email: String, password: String) {
        let json = createLoginJson(email: email, password: password)
        self.commonLogin(credentials: json, callback: { response in
            self.loginProcessCompleted(response: response)
        })
    }

    func loginProcessCompleted(response: UserAPIResponse) {
        guard let certificate = response.certificate, response.success else {
            self.presenter.showLoginFailureAlert()
            return
        }
        self.storeCertificate(certificate: certificate)
    }

    private func createLoginJson(email: String, password: String) -> JSON {
        var json = JSON()
        json["email"] = email
        json["password"] = password
        return json
    }
}
