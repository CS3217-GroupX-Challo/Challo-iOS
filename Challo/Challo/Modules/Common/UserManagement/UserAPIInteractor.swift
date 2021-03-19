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
        let globalState = UserState.globalState
        globalState.loggedIn = true
        globalState.name = certificate.name
        globalState.email = certificate.email
        globalState.token = certificate.token
        globalState.userId = certificate.userId
        print("LOGGED IN: \(globalState.loggedIn)")
        print(globalState.email)
    }
    
    func convertJSONToTourist(json: JSON) -> Tourist? {
        guard let userId = UUID(uuidString: json[Key.userId] as? String ?? ""),
              let email = json[Key.email] as? String,
              let name = json[Key.email] as? String else {
            return nil
        }
        
        let profileImg: String? = json[Key.profileImage] as? String
        let activeSince: Date? = json[Key.activeSince] as? Date
        let sex: Sex? = Sex(rawValue: json[Key.sex] as? String ?? "")
        let phone: String? = json[Key.phone] as? String
        
        return Tourist(userId: userId, email: email, profileImg: profileImg,
                       name: name, phone: phone,
                       dateJoined: activeSince, sex: sex)
    }
}
