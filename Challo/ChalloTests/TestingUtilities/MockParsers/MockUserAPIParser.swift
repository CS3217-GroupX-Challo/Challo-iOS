//
//  MockUserAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockUserAPIParser: UserAPIParser {
    override func parseUser(apiResponse: UserAPIParser.JSON) -> UserCertificate? {
        nil
    }
}
