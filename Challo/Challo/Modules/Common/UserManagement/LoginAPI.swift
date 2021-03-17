//
//  LoginAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class LoginAPI: UserAPIInteractor {

    private var api = AlamofireManager.alamofireManager
    private var loginUrl = "/user/login"
    weak var loginDelegate: LoginDelegate?

    func defaultLogin(credentials: JSON) {
        let failureResponse = LoginResponse(success: false, certificate: nil)
        api.post(url: loginUrl,
                 headers: AlamofireManager.HEADER(),
                 body: credentials) { res, err in
            if let err = err {
                print("Error: \(err)")
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            let parsed = self.parseUser(apiResponse: res)
            guard let certificate = parsed else {
                print("Unable to parse api response \(res)")
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            self.loginDelegate?.loginProcessCompleted(
                loginResponse: LoginResponse(success: true, certificate: certificate)
            )
        }
    }
}
