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

    func storeCertificate(certificate: UserCertificate) {
        globalState.storeCertificate(certificate: certificate)
        ChalloLogger.logger.log("Logged in")
        ChalloLogger.logger.log("Name: \(certificate.name)")
    }
}
