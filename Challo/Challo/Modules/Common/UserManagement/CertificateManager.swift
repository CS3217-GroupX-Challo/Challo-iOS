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
        guard let data = apiResponse["data"] as? JSON,
              let name = data["name"] as? String,
              let userId = data["userId"] as? String,
              let email = data["email"] as? String,
              let tokenJson = data["token"] as? JSON,
              let token = tokenJson["token"] as? String else {
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
        ChalloLogger.logger.log("Logged in: \(globalState.loggedIn)")
        ChalloLogger.logger.log("Name: \(globalState.name)")
    }

}
