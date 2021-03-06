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
    static let userId = "458c466e-182f-491c-b05d-6f7f186c40b2"
    static let name = "test"
    static let phone = "12345678"
    static let sex = "male"
    static let profileImg = "image"
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
        json["profileImg"] = profileImg
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
                        profileImg: profileImg,
                        token: tokenString,
                        userId: userId,
                        user: nil)
    }
}
