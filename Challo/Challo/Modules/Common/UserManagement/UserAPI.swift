//
//  UserAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import Foundation

protocol UserAPI: UserAPIInteractor {
    func commonLogin(credentials: JSON,
                     callback: @escaping (UserAPIResponse) -> Void)
    func commonRegister(details: JSON,
                        callback: @escaping (UserAPIResponse) -> Void)
    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String)
}

extension UserAPI {

    var loginUrl: String {
        "/user/login"
    }

    var registerUrl: String {
        "/user/register"
    }

    func commonLogin(credentials: JSON,
                     callback: @escaping (UserAPIResponse) -> Void) {
        sendUserPostRequest(url: loginUrl,
                            body: credentials,
                            callback: callback)
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
    
    func getTourist(userId: UUID, callback: @escaping (Tourist) -> Void, url: String = "/user") {
        let api = AlamofireManager.alamofireManager
        api.get(url: url + "/" + userId.uuidString,
                headers: [String: String]()) { response, error in
            if error != nil {
                return
            }
            
            guard let touristInfo = response["data"] as? JSON else {
                return
            }
            
            guard let tourist = convertJSONToTourist(json: touristInfo) else {
                return
            }
            
            callback(tourist)
        }
    }
}
