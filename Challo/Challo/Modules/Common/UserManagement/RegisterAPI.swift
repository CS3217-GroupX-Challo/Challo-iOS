//
//  RegisterAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

protocol RegisterAPI: UserAPIInteractor {

    var networkManager: AlamofireManager { get }
    var registerUrl: String { get }

    func commonRegister(details: JSON,
                        callback: @escaping (UserAPIResponse) -> Void)
}

extension RegisterAPI {

    func commonRegister(details: JSON,
                        callback: @escaping (UserAPIResponse) -> Void) {
        networkManager.post(url: registerUrl,
                            headers: AlamofireManager.HEADER(),
                            body: details) { res, err in
            if let err = err {
                print("ERR! \(err)")
                let failureResponse = UserAPIResponse(success: false, error: err)
                callback(failureResponse)
                return
            }
            guard let certificate = self.parseUser(apiResponse: res) else {
                let failureResponse = UserAPIResponse(success: false)
                callback(failureResponse)
                return
            }
            let successResponse = UserAPIResponse(success: true, certificate: certificate)
            callback(successResponse)
        }
    }
}
