//
//  MockCertificateManager.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

@testable import Challo

class MockCertificateManager: CertificateManager {

    var state: MockUserState

    init(state: MockUserState) {
        self.state = state
    }

    override func storeCertificate(certificate: UserCertificate) {
        state.storeCertificate(certificate: certificate)
    }
}
