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
}
