//
//  RegisterAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import Foundation

protocol RegisterAPI: UserAPIInteractor {

    func commonRegister(details: JSON,
                        callback: @escaping (UserAPIResponse) -> Void)
}

extension RegisterAPI {

    var registerUrl: String {
        "/user/register"
    }

    func commonRegister(details: JSON,
                        callback: @escaping (UserAPIResponse) -> Void) {
        sendUserPostRequest(url: registerUrl,
                            body: details,
                            callback: callback)
    }

    func registerUserType(url: String,
                          body: JSON,
                          callback: @escaping (Error?) -> Void) {
        networkManager.post(url: url,
                            headers: AlamofireManager.HEADER(),
                            body: body) { _, err in
            if let err = err {
                ChalloLogger.logger.log("Failed to create specific user type \(err as NSObject)")
                callback(err)
            }
            callback(nil)
        }
    }
}
