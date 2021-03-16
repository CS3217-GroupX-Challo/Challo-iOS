//
//  UserAPIInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//
import SwiftUI

protocol UserAPIInteractor {

    typealias JSON = AlamofireManager.JSON
    var api: AlamofireManager { get }

    func parseUser(apiResponse: JSON) -> UserCertificate?
    func storeCertificate(certificate: UserCertificate)
}

extension UserAPIInteractor {

    func parseUser(apiResponse: JSON) -> UserCertificate? {
        guard let data = apiResponse["data"] as? JSON,
              let name = data["name"] as? String,
              let userId = data["userId"] as? String,
              let email = data["email"] as? String,
              let tokenJson = data["token"] as? JSON,
              let token = tokenJson["token"] as? String else {
            print("API response wrong shape: \(apiResponse)")
            return nil
        }
        return UserCertificate(name: name,
                               email: email,
                               token: token,
                               userId: userId)
    }

    func storeCertificate(certificate: UserCertificate) {
        let defaults = UserDefaults.standard
        defaults.setValue(certificate.name, forKey: "name")
        defaults.setValue(certificate.email, forKey: "email")
        defaults.setValue(certificate.token, forKey: "token")
        defaults.setValue(certificate.userId, forKey: "userId")
        defaults.setValue(true, forKey: "logged_in")
    }
}
