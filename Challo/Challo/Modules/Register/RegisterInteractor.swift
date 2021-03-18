import Combine

class RegisterInteractor: InteractorProtocol, RegisterAPI {

    let networkManager = AlamofireManager.alamofireManager
    let registerUrl = "/user/register"

    weak var presenter: RegisterPresenter!

    func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        self.commonRegister(details: json) { response in
            self.registrationProcessCompleted(response: response)
        }
    }

    func createRegisterJson(details: RegistrationDetails) -> JSON {
        var json = JSON()
        json["name"] = details.name
        json["phone"] = details.phone
        json["email"] = details.email
        json["password"] = details.password
        return json
    }

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

    func registerUserType(url: String, body: JSON) {
        networkManager.post(url: url,
                            headers: AlamofireManager.HEADER(),
                            body: body) { _, err in
            if let err = err {
                print("error: \(err)")
                self.presenter.showRegisterFailureAlert()
                return
            }
        }
    }
}
