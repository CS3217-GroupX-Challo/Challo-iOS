//
//  MockUserAPI.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 28/3/21.
//

@testable import Challo

class MockUserAPI: UserAPI {

    var shouldSucceed = false

    init() {
        super.init(userParser: MockUserAPIParser(),
                   networkManager: MockNetworkManager(json: JSON()))
    }

    override func commonLogin(credentials: JSON,
                              callback: @escaping (UserAPIResponse) -> Void) {
        let response = shouldSucceed
            ? UserAPIResponse(success: true)
            : UserAPIResponse(success: false)
        callback(response)
    }

    override func commonRegister(details: JSON,
                                 callback: @escaping (UserAPIResponse) -> Void) {
        let response = shouldSucceed
            ? UserAPIResponse(success: true)
            : UserAPIResponse(success: false)
        callback(response)
    }
}
