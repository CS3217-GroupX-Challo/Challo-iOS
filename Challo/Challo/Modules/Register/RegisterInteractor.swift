import Combine

class RegisterInteractor: InteractorProtocol {

    typealias JSON = AlamofireManager.JSON
    private let api = RegisterAPI()

    weak var presenter: RegisterPresenter!

    init() {
        self.api.registerDelegate = self
    }

    func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        api.register(details: json)
    }

    private func createRegisterJson(details: RegistrationDetails) -> JSON {
        var json = JSON()
        json["name"] = details.name
        json["phone"] = details.phone
        json["email"] = details.email
        json["password"] = details.password
        return json
    }
}

// MARK: RegisterDelegate
extension RegisterInteractor: RegisterDelegate {

    func registrationProcessCompleted(response: RegisterResponse) {
        guard let certificate = response.certificate, response.success else {
            print("not working")
            self.presenter.showRegisterFailureAlert()
            return
        }
        api.storeCertificate(certificate: certificate)
    }
}
