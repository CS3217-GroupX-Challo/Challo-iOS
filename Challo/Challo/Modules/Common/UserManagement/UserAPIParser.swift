//
//  UserAPIParser.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//
import SwiftUI

class UserAPIParser {
    typealias JSON = NetworkManager.JSON

    unowned var userState: UserStateProtocol
    
    init(userState: UserStateProtocol) {
        self.userState = userState
    }
    
    func parseToken(_ data: JSON) -> String? {
        guard let tokenJson = data[Key.token] as? JSON,
              let token = tokenJson[Key.token] as? String else {
            return nil
        }
        return token
    }
    
    func parseUser(apiResponse: JSON, doParseToken: Bool = true) -> UserCertificate? {
        guard let data = apiResponse[Key.data] as? JSON,
              let name = data[Key.name] as? String,
              let userId = data[Key.userId] as? String,
              let email = data[Key.email] as? String else {
            ChalloLogger.logger.log("API response wrong shape: \(apiResponse)")
            return nil
        }
        let token = doParseToken ? (parseToken(data) ?? userState.token) : userState.token
        let profileImg = data[Key.profileImage] as? String ?? ""
        return UserCertificate(name: name,
                               email: email,
                               profileImg: profileImg,
                               token: token,
                               userId: userId)
    }
}
