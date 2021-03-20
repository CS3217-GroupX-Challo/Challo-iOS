//
//  TouristAPIInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import Foundation

class TouristAPIParser {

    typealias JSON = AlamofireManager.JSON

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
