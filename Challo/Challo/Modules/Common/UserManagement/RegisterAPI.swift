//
//  RegisterAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

import Foundation

protocol RegisterAPI: AnyObject {

    typealias JSON = AlamofireManager.JSON
    var userAPI: UserAPI { get }
    var userTypeUrl: String { get }
    var networkManager: AlamofireManager { get }

    func register(details: RegistrationDetails,
                  callback: @escaping (UserAPIResponse) -> Void)
    func createUserTypeJSON(details: RegistrationDetails,
                            certificate: UserCertificate?) -> JSON?
    func parseUserTypeJSON(json: JSON) -> User?
}

extension RegisterAPI {

    func register(details: RegistrationDetails,
                  callback: @escaping (UserAPIResponse) -> Void) {
        let json = createRegisterJson(details: details)
        self.userAPI.commonRegister(details: json) { [weak self] response in
            guard let self = self else {
                return
            }

            if !response.success {
                callback(response)
            }

            guard let json = self.createUserTypeJSON(details: details,
                                                     certificate: response.certificate) else {
                return
            }

            self.registerUserType(url: self.userTypeUrl,
                                  body: json) { res, err in
                if err != nil {
                    callback(UserAPIResponse(success: false, error: err))
                }
                
                let user = self.parseUserTypeJSON(json: res)
                var newResponse = response
                newResponse.certificate?.user = user
                callback(newResponse)
            }
        }
    }

    func registerUserType(url: String,
                          body: JSON,
                          callback: @escaping (JSON, Error?) -> Void) {
        networkManager.post(url: url,
                            headers: AlamofireManager.HEADER(),
                            body: body) { res, err in
            if let err = err {
                ChalloLogger.logger.log("Failed to create specific user type \(err as NSObject)")
                callback(res, err)
            }
            callback(res, nil)
        }
    }

    func createRegisterJson(details: RegistrationDetails) -> JSON {
        var json = JSON()
        json[Key.name] = details.name
        json[Key.email] = details.email
        json[Key.password] = details.password
        if let phone = details.phone {
            json[Key.phone] = phone
        }
        return json
    }
}
