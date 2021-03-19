//
//  RegistrationLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

protocol RegistrationLogic: RegisterAPI, AnyObject {
    var userTypeUrl: String { get }
    func register(details: RegistrationDetails,
                  callback: @escaping (UserAPIResponse) -> Void)
    func createUserTypeJSON(details: RegistrationDetails,
                            certificate: UserCertificate?) -> JSON?
}

extension RegistrationLogic {

    func register(details: RegistrationDetails,
                  callback: @escaping (UserAPIResponse) -> Void) {
        let json = createRegisterJson(details: details)
        self.commonRegister(details: json) { [weak self] response in
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
                                  body: json) { err in
                if err != nil {
                    callback(UserAPIResponse(success: false, error: err))
                    return
                }
                callback(response)
            }
        }
    }

    func createRegisterJson(details: RegistrationDetails) -> JSON {
        var json = JSON()
        json["name"] = details.name
        json["email"] = details.email
        json["password"] = details.password
        if let phone = details.phone {
            json["phone"] = phone
        }
        return json
    }
}
