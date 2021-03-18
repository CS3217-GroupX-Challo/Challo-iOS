//
//  RegisterAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

class RegisterAPI: UserAPIInteractor {

    weak var registerDelegate: RegisterDelegate?
    private var api = AlamofireManager.alamofireManager
    private var registerUrl = "/user/register"

    func register(details: JSON) {
        let failureResponse = RegisterResponse(success: false)
        api.post(url: registerUrl,
                 headers: AlamofireManager.HEADER(),
                 body: details) { res, err in
            if let err = err {
                print("ERR! \(err)")
                self.registerDelegate?.registrationProcessCompleted(response: failureResponse)
                return
            }
            guard let certificate = self.parseUser(apiResponse: res) else {
                self.registerDelegate?.registrationProcessCompleted(response: failureResponse)
                return
            }

            let sucessResponse = RegisterResponse(success: true, certificate: certificate)
            self.registerDelegate?.registrationProcessCompleted(response: sucessResponse)
        }
    }
}
