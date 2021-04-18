import Combine
import Foundation

protocol RegisterInteractor: InteractorProtocol where Presenter: RegisterPresenter {

    var certificateManager: CertificateManager { get }
    var presenter: Presenter! { get set }

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
        #if GUIDE
        certificateManager.storeCertificate(certificate: certificate, isNewUser: true, completedOnboarding: false)
        #else
        certificateManager.storeCertificate(certificate: certificate, isNewUser: true)
        #endif
        presenter.showRegisterSuccessAlert()
    }
}
