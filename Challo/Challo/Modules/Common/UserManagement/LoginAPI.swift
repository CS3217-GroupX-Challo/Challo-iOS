//
//  LoginAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

import Foundation

protocol LoginAPI: AnyObject {

    typealias JSON = NetworkManager.JSON
    var userAPI: UserAPI { get }
    var userTypeUrl: String { get }

    func login(email: String,
               password: String,
               callback: @escaping (UserAPIResponse) -> Void)
    func parseUserTypeJson(json: JSON) -> User?
}

extension LoginAPI {

    func login(email: String,
               password: String,
               callback: @escaping (UserAPIResponse) -> Void) {
        let json = createLoginJson(email: email, password: password)
        userAPI.commonLogin(credentials: json, callback: { [weak self] response in
            guard let self = self else {
                return
            }

            guard let userId = response.certificate?.userId else {
                callback(UserAPIResponse(success: false))
                return
            }

            self.getUserType(url: self.userTypeUrl,
                             userId: userId) { json, err in
                if err != nil {
                    callback(UserAPIResponse(success: false))
                }
                
                let user = self.parseUserTypeJson(json: json)
                var newResponse = response
                newResponse.certificate?.user = user
                callback(newResponse)
            }
        })
    }

    func getUserType(url: String,
                     userId: String,
                     callback: @escaping (JSON, Error?) -> Void) {
        let networkManager = APINetwork.api
        networkManager.get(url: url + "/" + userId,
                           headers: NetworkManager.HEADER()) { res, err in
            if let err = err {
                ChalloLogger.logger.log("Failed to get specific user type \(err as NSObject)")
                callback(res, err)
            }
            callback(res, nil)
        }
    }

    func createLoginJson(email: String, password: String) -> JSON {
        var json = JSON()
        json[Key.email] = email
        json[Key.password] = password
        return json
    }
}
