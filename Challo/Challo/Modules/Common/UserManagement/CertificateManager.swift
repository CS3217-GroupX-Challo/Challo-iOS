//
//  CertificateManager.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

protocol CertificateManager {

    typealias JSON = AlamofireManager.JSON

    func storeCertificate(certificate: UserCertificate)
    func parseUser(apiResponse: JSON) -> UserCertificate?
}

extension CertificateManager {

    func parseUser(apiResponse: JSON) -> UserCertificate? {
        guard let data = apiResponse[Key.data] as? JSON,
              let name = data[Key.name] as? String,
              let userId = data[Key.userId] as? String,
              let email = data[Key.email] as? String,
              let tokenJson = data[Key.token] as? JSON,
              let token = tokenJson[Key.token] as? String else {
            ChalloLogger.logger.log("API response wrong shape: \(apiResponse)")
            return nil
        }
        return UserCertificate(name: name,
                               email: email,
                               token: token,
                               userId: userId)
    }

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
