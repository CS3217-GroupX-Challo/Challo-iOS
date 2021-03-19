//
//  UserAPIInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//
import SwiftUI

protocol UserAPIInteractor {
    var networkManager: AlamofireManager { get }
    typealias JSON = AlamofireManager.JSON
    func parseUser(apiResponse: JSON) -> UserCertificate?
    func storeCertificate(certificate: UserCertificate)
}

extension UserAPIInteractor {

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

    func sendUserPostRequest(url: String,
                         body: JSON,
                         callback: @escaping (UserAPIResponse) -> Void) {
        networkManager.post(url: url,
                            headers: AlamofireManager.HEADER(),
                            body: body) { res, err in
            if let err = err {
                ChalloLogger.logger.log("Error: \(err as NSObject)")
                let failureResponse = UserAPIResponse(success: false, error: err)
                callback(failureResponse)
                return
            }
            guard let certificate = self.parseUser(apiResponse: res) else {
                ChalloLogger.logger.log("Unable to parse api response \(res)")
                let failureResponse = UserAPIResponse(success: false)
                callback(failureResponse)
                return
            }
            let successResponse = UserAPIResponse(success: true, certificate: certificate)
            callback(successResponse)
        }
    }
}
