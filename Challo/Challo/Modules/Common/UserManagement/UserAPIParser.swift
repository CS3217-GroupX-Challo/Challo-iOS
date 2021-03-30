//
//  UserAPIParser.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//
import SwiftUI

class UserAPIParser {
    typealias JSON = NetworkManager.JSON

    func parseUser(apiResponse: JSON) -> UserCertificate? {
        guard let data = apiResponse[Key.data] as? JSON,
              let name = data[Key.name] as? String,
              let userId = data[Key.userId] as? String,
              let email = data[Key.email] as? String,
              let tokenJson = data[Key.token] as? JSON,
              let token = tokenJson[Key.token] as? String else {
            ChalloLogger.logger.log("API response wrong shape: \(apiResponse)")
            return nil
        }
        return UserCertificate(name: name,
                               email: email,
                               token: token,
                               userId: userId)
    }
}
