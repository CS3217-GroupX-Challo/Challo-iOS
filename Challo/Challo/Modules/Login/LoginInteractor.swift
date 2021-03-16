import SwiftUI

class LoginInteractor: InteractorProtocol {

    typealias JSON = AlamofireManager.JSON
    private let api = AlamofireManager.alamofireManager
    private let loginUrl = "/user/login"

    weak var presenter: LoginPresenter!

    @AppStorage("logged_in") var loggedIn = false
    @AppStorage("email") var email = ""
    @AppStorage("name") var name = ""
    @AppStorage("token") var token = ""
    @AppStorage("userId") var userId = ""

    private var facebookLoginService = FacebookLoginService()

    init() {
        facebookLoginService.loginDelegate = self
    }

    func logInWithFacebook() {
        facebookLoginService.login()
    }

    func defaultLogin(email: String, password: String) {
        let json = createLoginJson(email: email, password: password)
        api.post(url: loginUrl,
                 headers: AlamofireManager.HEADER(),
                 body: json) { res, err in
            if let err = err {
                print("Error: \(err)")
                return
            }
            let response = self.parseApiResponse(response: res)
            if !response.success {
                return
            }
            self.storeLoginResponse(response: response)
        }
    }

    private func createLoginJson(email: String, password: String) -> JSON {
        var json = JSON()
        json["email"] = email
        json["password"] = password
        return json
    }

    private func parseApiResponse(response: JSON) -> LoginResponse {
        guard let data = response["data"] as? JSON,
              let name = data["name"] as? String,
              let userId = data["userId"] as? String,
              let email = data["email"] as? String,
              let tokenJson = data["token"] as? JSON,
              let token = tokenJson["token"] as? String else {
            print("API response wrong shape: \(response)")
            return LoginResponse(success: false)
        }
        return LoginResponse(success: true,
                             email: email,
                             name: name,
                             token: token,
                             userId: userId)
    }
}

// MARK: Login Delegate
extension LoginInteractor: LoginDelegate {

    func loginProcessCompleted(loginResponse: LoginResponse) {
        self.storeLoginResponse(response: loginResponse)
    }

    private func storeLoginResponse(response: LoginResponse) {
        loggedIn = response.success
        email = response.email ?? ""
        name = response.name ?? ""
        token = response.token ?? ""
        userId = response.userId ?? ""
        print("LOGGED IN: \(loggedIn)")
        print("EMAIL: \(email)")
        print("NAME: \(name)")
        print("TOKEN: \(token)")
        print("userId: \(userId)")
    }
}
