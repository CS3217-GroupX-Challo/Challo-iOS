//
//  MockUserAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockUserAPIParser: UserAPIParser {

    typealias JSON = NetworkManager.JSON
    typealias Response = MockUserAPIResponses

    override func parseUser(apiResponse: JSON, doParseToken: Bool = true) -> UserCertificate? {
        guard let success = apiResponse["success"] as? Bool,
              success else {
            return nil
        }
        return Response.certificate
    }
}
