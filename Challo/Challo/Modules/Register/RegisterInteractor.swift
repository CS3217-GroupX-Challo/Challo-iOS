import Combine

class RegisterInteractor: InteractorProtocol {

    typealias JSON = AlamofireManager.JSON
    weak var presenter: RegisterPresenter!
    private var api = AlamofireManager.alamofireManager
    private var registerUrl = "/user/register"

    func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        api.post(url: registerUrl,
                 headers: AlamofireManager.HEADER(),
                 body: json) { data, err in
            if let err = err {
                print("ERR! \(err)")
                return
            }
            print(data)
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
