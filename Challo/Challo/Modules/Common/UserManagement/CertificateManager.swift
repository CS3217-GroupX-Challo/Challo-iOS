//
//  CertificateManager.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

protocol CertificateManager {

    typealias JSON = AlamofireManager.JSON

    func storeCertificate(certificate: UserCertificate)
}

extension CertificateManager {

    func storeCertificate(certificate: UserCertificate) {
        let globalState = UserState.globalState
        globalState.loggedIn = true
        globalState.name = certificate.name
        globalState.email = certificate.email
        globalState.token = certificate.token
        globalState.userId = certificate.userId
        globalState.user = certificate.user
        ChalloLogger.logger.log("Logged in: \(globalState.loggedIn)")
        ChalloLogger.logger.log("Name: \(globalState.name)")
    }

}
