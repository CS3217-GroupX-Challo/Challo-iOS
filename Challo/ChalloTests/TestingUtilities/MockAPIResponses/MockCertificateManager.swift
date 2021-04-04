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
        super.init(userState: state)
    }

    override func storeCertificate(certificate: UserCertificate, isNewUser: Bool = false) {
        state.storeCertificate(certificate: certificate, isNewUser: isNewUser)
    }
}
