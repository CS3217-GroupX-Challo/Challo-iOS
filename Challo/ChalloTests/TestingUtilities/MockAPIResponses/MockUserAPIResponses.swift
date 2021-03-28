//
//  MockUserAPIResponses.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 20/3/21.
//

@testable import Challo

struct MockUserAPIResponses {

    typealias JSON = NetworkManager.JSON

    static let email = "test@email.com"
    static let userId = "test12345"
    static let name = "test"
    static let phone = "12345678"
    static let sex = "male"
    static let profileImage = "image"
    static let activeSince = "2021-03-19T17:25:36.743Z"
    static let dateJoined = "2021-03-19T17:25:36.743Z"
    static let tokenString = "test token"

    static var validToken: JSON {
        var json = JSON()
        json["token"] = tokenString
        json["expiresIn"] = "1d"
        return json
    }

    static var validUser: JSON {
        var json = JSON()
        json["token"] = validToken
        json["email"] = email
        json["userId"] = userId
        json["name"] = name
        json["phone"] = phone
        json["sex"] = sex
        json["profileImg"] = profileImage
        json["activeSince"] = activeSince
        json["dateJoined"] = dateJoined
        return json
    }

    static var validResponse: JSON {
        var json = JSON()
        json["message"] = "User successfully login"
        json["data"] = validUser
        return json
    }
    
    static var failureResponse: JSON {
        var json = JSON()
        json["message"] = "Failed to login"
        return json
    }

    static var certificate: UserCertificate {
        UserCertificate(name: name,
                        email: email,
                        token: tokenString,
                        userId: userId,
                        user: nil)
    }
}
