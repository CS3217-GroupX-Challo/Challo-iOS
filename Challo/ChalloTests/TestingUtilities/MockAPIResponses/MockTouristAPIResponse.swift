//
//  TouristAPIResponse.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import Foundation

struct MockTouristAPIResponse: MockAPIResponse {
    typealias JSON = NetworkManager.JSON
    
    static let userId = UUID(uuidString: "85e6f125-91be-45f6-bb27-0a3a468a487a") ?? UUID()
    static let name: String = "Mr Tourist"
    static let phone: String = "91234567"
    static let email: String = "tourist@sg.com"
    static let sex = Sex.Male
    static let password: String = "123"
    static let profileImg: String? = nil
    static let dateJoined: Date? = Date.construct(with: "2021-03-20T17:54:59.022Z")
    
    static var validTouristJSON: JSON {
        var json = JSON()
        json[Key.email] = email
        json[Key.userId] = userId.uuidString
        json[Key.password] = password
        json[Key.name] = name
        json[Key.phone] = phone
        json[Key.sex] = "male"
        json[Key.profileImage] = nil
        json[Key.dateJoined] = dateJoined
        return json
    }
    
    static var validResponse: JSON {
        var json = JSON()
        json["message"] = "Tourist found"
        json["data"] = validTouristJSON
        return json
    }
}
