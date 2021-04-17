//
//  MockUserAPI.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 28/3/21.
//

@testable import Challo

class MockUserAPI: UserAPI {

    var shouldSucceed = true

    init() {
        super.init(userParser: MockUserAPIParser(userState: MockUserState()),
                   networkManager: MockNetworkManager(json: JSON()))
    }

    override func commonLogin(credentials: JSON,
                              callback: @escaping (UserAPIResponse) -> Void) {
        let response = shouldSucceed
            ? UserAPIResponse(success: true, certificate: MockUserAPIResponses.certificate)
            : UserAPIResponse(success: false)
        callback(response)
    }

    override func commonRegister(details: JSON,
                                 callback: @escaping (UserAPIResponse) -> Void) {
        let response = shouldSucceed
            ? UserAPIResponse(success: true, certificate: MockUserAPIResponses.certificate)
            : UserAPIResponse(success: false)
        callback(response)
    }
}
