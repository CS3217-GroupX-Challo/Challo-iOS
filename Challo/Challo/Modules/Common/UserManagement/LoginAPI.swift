//
//  LoginAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

protocol LoginAPI: UserAPIInteractor {

    var networkManager: AlamofireManager { get }
    var loginUrl: String { get }

    func commonLogin(credentials: JSON, callback: @escaping (UserAPIResponse) -> Void)
}

extension LoginAPI {

    func commonLogin(credentials: JSON,
                     callback: @escaping (UserAPIResponse) -> Void) {
        networkManager.post(url: loginUrl,
                            headers: AlamofireManager.HEADER(),
                            body: credentials) { res, err in
            if let err = err {
                print("Error: \(err)")
                let failureResponse = UserAPIResponse(success: false, error: err)
                callback(failureResponse)
                return
            }
            guard let certificate = self.parseUser(apiResponse: res) else {
                print("Unable to parse api response \(res)")
                let failureResponse = UserAPIResponse(success: false)
                callback(failureResponse)
                return
            }
            let successResponse = UserAPIResponse(success: true, certificate: certificate)
            callback(successResponse)
        }
    }
}
