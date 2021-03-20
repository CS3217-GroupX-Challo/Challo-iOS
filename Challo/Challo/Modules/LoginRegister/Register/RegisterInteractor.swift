import Combine
import Foundation

protocol RegisterInteractor: CertificateManager, AnyObject {

    var presenter: RegisterPresenter! { get set }

    func register(details: RegistrationDetails)
}

extension RegisterInteractor {

    func registrationProcessCompleted(response: UserAPIResponse) {
        guard let certificate = response.certificate,
              response.success,
              response.error == nil else {
            self.presenter.showRegisterFailureAlert()
            return
        }
        self.storeCertificate(certificate: certificate)
        return
    }
}
