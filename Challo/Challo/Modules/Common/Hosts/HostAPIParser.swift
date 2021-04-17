//
//  HostAPIParser.swift
//  Challo
//
//  Created by Tan Le Yang on 17/4/21.
//

import Foundation

class HostAPIParser: APIParser {

    typealias JSON = NetworkManager.JSON

    func convertJSONToHost(json: JSON) -> Host? {
        guard let userId = UUID(uuidString: json[Key.userId] as? String ?? ""),
              let email = json[Key.email] as? String,
              let name = json[Key.name] as? String else {
            return nil
        }
        
        let profileImg: String? = json[Key.profileImage] as? String
        let dateJoinedString: String? = json[Key.dateJoined] as? String
        let dateJoined: Date? = Date.construct(with: dateJoinedString ?? "")
        let sexString: String? = json[Key.sex] as? String
        let sex: Sex? = Sex.convertToSex(from: sexString ?? "")
        let phone: String? = json[Key.phone] as? String
            
        return Host(userId: userId, email: email, profileImg: profileImg,
                    name: name, phone: phone, dateJoined: dateJoined, sex: sex)
    }
}
