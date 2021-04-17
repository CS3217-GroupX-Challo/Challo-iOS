//
//  MockHostAPIResponses.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 17/4/21.
//

import Foundation
@testable import Challo

struct MockHostAPIResponses {

    typealias JSON = NetworkManager.JSON
    
    static let userId = UUID(uuidString: "85e6f125-91be-45f6-bb27-0a3a468a487a") ?? UUID()
    static let name: String = "Mr Host"
    static let phone: String = "81234167"
    static let email: String = "host@sg.com"
    static let sex = Sex.Male
    static let profileImg: String? = nil
    static let dateJoinedString: String = "2021-03-20T17:54:59.022Z"
    static let dateJoined: Date? = Date.construct(with: dateJoinedString)
    
    static var validHostJSON: JSON {
        var json = JSON()
        json[Key.email] = email
        json[Key.userId] = userId.uuidString
        json[Key.name] = name
        json[Key.phone] = phone
        json[Key.sex] = "male"
        json[Key.profileImage] = nil
        json[Key.dateJoined] = dateJoinedString
        return json
    }
    
    static var validResponse: JSON {
        var json = JSON()
        json["data"] = validHostJSON
        return json
    }
    
    static var host: Host {
        Host(userId: userId, email: email, profileImg: profileImg,
             name: name, phone: phone, dateJoined: dateJoined, sex: sex)
    }
}
