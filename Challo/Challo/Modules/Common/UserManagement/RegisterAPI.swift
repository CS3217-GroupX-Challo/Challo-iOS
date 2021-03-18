//
//  RegisterAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import Foundation

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
                ChalloLogger.logger.log("Error: \(err as NSObject)")
                let failureResponse = UserAPIResponse(success: false, error: err)
                callback(failureResponse)
                return
            }
            guard let certificate = self.parseUser(apiResponse: res) else {
                ChalloLogger.logger.log("Unable to parse api response \(res)")
                let failureResponse = UserAPIResponse(success: false)
                callback(failureResponse)
                return
            }
            let successResponse = UserAPIResponse(success: true, certificate: certificate)
            callback(successResponse)
        }
    }
}
