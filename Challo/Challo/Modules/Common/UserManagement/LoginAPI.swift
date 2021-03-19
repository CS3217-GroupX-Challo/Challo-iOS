//
//  LoginAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//
import Foundation

protocol LoginAPI: UserAPIInteractor {

    func commonLogin(credentials: JSON, callback: @escaping (UserAPIResponse) -> Void)
}

extension LoginAPI {

    var loginUrl: String {
        "/user/login"
    }

    func commonLogin(credentials: JSON,
                     callback: @escaping (UserAPIResponse) -> Void) {
        sendUserPostRequest(url: loginUrl,
                            body: credentials,
                            callback: callback)
    }
}
