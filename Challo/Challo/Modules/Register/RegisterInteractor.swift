import Combine
import Foundation

protocol RegisterInteractor: RegisterAPI, AnyObject {

    var networkManager: AlamofireManager { get }
    var registerUrl: String { get }
    var presenter: RegisterPresenter! { get set }

    func register(details: RegistrationDetails)
    func createRegisterJson(details: RegistrationDetails) -> JSON
    func registrationProcessCompleted(response: UserAPIResponse)
    func registerUserType(url: String, body: JSON)
}

extension RegisterInteractor {

    var registerUrl: String {
        "/user/register"
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
                ChalloLogger.logger.log("Failed to create specific user type \(err as NSObject)")
                self.presenter.showRegisterFailureAlert()
                return
            }
        }
    }
}
