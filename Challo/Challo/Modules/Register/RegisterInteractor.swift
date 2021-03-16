import Combine

class RegisterInteractor: InteractorProtocol, UserAPIInteractor {

    typealias JSON = AlamofireManager.JSON
    let api = AlamofireManager.alamofireManager
    private let registerUrl = "/user/register"

    weak var presenter: RegisterPresenter!

    func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        api.post(url: registerUrl,
                 headers: AlamofireManager.HEADER(),
                 body: json) { res, err in
            if let err = err {
                print("ERR! \(err)")
                self.presenter.showRegisterFailureAlert()
                return
            }

            guard let certificate = self.parseUser(apiResponse: res) else {
                self.presenter.showRegisterFailureAlert()
                return
            }

            self.storeCertificate(certificate: certificate)
        }
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
