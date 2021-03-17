//
//  LoginAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

protocol LoginAPI: UserAPIInteractor {

    var loginUrl: String { get }
    var loginDelegate: LoginDelegate? { get }
    func defaultLogin(email: String, password: String)
}

extension LoginAPI {

    func defaultLogin(email: String, password: String) {
        let json = createLoginJson(email: email, password: password)
        let failureResponse = LoginResponse(success: false, certificate: nil)
        api.post(url: loginUrl,
                 headers: AlamofireManager.HEADER(),
                 body: json) { res, err in
            if let err = err {
                print("Error: \(err)")
                loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            let parsed = self.parseUser(apiResponse: res)
            guard let certificate = parsed else {
                print("Unable to parse api response \(res)")
                loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            loginDelegate?.loginProcessCompleted(loginResponse: LoginResponse(success: true, certificate: certificate))
        }
    }

    func createLoginJson(email: String, password: String) -> JSON {
        var json = JSON()
        json["email"] = email
        json["password"] = password
        return json
    }
}
