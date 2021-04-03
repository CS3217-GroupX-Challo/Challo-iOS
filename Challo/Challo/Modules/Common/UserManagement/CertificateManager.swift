//
//  CertificateManager.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class CertificateManager {

    var globalState: UserStateProtocol
    typealias JSON = NetworkManager.JSON

    init(userState: UserStateProtocol) {
        self.globalState = userState
    }

    func storeCertificate(certificate: UserCertificate, isNewUser: Bool = false) {
        globalState.storeCertificate(certificate: certificate, isNewUser: isNewUser)
        ChalloLogger.logger.log("Logged in")
        ChalloLogger.logger.log("Name: \(certificate.name)")
        ChalloLogger.logger.log("User id: \(certificate.userId)")
    }
}
