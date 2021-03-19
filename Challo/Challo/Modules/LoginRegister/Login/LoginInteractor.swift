import SwiftUI

protocol LoginInteractor: LoginAPI, AnyObject {

    var presenter: LoginPresenter! { get set }

    func defaultLogin(email: String, password: String)
}

extension LoginInteractor {

    func loginProcessCompleted(response: UserAPIResponse) {
        guard let certificate = response.certificate, response.success else {
            self.presenter.showLoginFailureAlert()
            return
        }
        self.storeCertificate(certificate: certificate)
    }
}
