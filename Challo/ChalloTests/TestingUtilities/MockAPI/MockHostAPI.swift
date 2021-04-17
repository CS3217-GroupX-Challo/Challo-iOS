//
//  MockHostAPI.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 17/4/21.
//

import Foundation
@testable import Challo

class MockHostAPI: HostAPIProtocol {
    func getHost(userId: UUID, callback: @escaping (Host?) -> Void) {
        callback(MockHostAPIResponses.host)
    }
}
