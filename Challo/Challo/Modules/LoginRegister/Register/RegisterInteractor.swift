import Combine
import Foundation

protocol RegisterInteractor: RegisterAPI, AnyObject {

    var presenter: RegisterPresenter! { get set }

    func register(details: RegistrationDetails)
}

extension RegisterInteractor {

    func registrationProcessCompleted(response: UserAPIResponse) {
        print("REGISTRATION PROCESS COMPELTED")
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
