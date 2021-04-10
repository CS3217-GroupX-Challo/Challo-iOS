import SwiftUI

protocol LoginInteractor: InteractorProtocol where Presenter: LoginPresenter {

    var certificateManager: CertificateManager { get }
    var presenter: Presenter! { get set }

    func defaultLogin(email: String, password: String)
}

extension LoginInteractor {

    func loginProcessCompleted(response: UserAPIResponse) {
        guard let certificate = response.certificate, response.success else {
            self.presenter.showLoginFailureAlert()
            return
        }
        certificateManager.storeCertificate(certificate: certificate)
    }
}
