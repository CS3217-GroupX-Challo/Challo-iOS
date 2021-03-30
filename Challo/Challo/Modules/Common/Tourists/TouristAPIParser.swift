//
//  TouristAPIInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import Foundation

class TouristAPIParser: APIParser {

    typealias JSON = NetworkManager.JSON

    func convertJSONToTourist(json: JSON) -> Tourist? {
        guard let userId = UUID(uuidString: json[Key.userId] as? String ?? ""),
            let email = json[Key.email] as? String,
            let name = json[Key.name] as? String else {
            return nil
        }
        
        let profileImg: String? = json[Key.profileImage] as? String
        let activeSinceString: String? = json[Key.activeSince] as? String
        let activeSince: Date? = Date.construct(with: activeSinceString ?? "")
        let sexString: String? = json[Key.sex] as? String
        let sex: Sex? = Sex.convertToSex(from: sexString ?? "")
        let phone: String? = json[Key.phone] as? String
            
        return Tourist(userId: userId, email: email, profileImg: profileImg,
                       name: name, phone: phone,
                       dateJoined: activeSince, sex: sex)
    }
}
