//
//  UserAPIInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 16/3/21.
//
import SwiftUI

protocol UserAPIInteractor: CertificateManager {

    var networkManager: AlamofireManager { get }
    typealias JSON = AlamofireManager.JSON
}

extension UserAPIInteractor {

    func sendUserPostRequest(url: String,
                             body: JSON,
                             callback: @escaping (UserAPIResponse) -> Void) {
        networkManager.post(url: url,
                            headers: AlamofireManager.HEADER(),
                            body: body) { res, err in
            if let err = err {
                handleErrorResponse(error: err, callback: callback)
                return
            }
            handleSuccessResponse(response: res, callback: callback)
        }
    }

    private func handleErrorResponse(error: Error,
                                     callback: @escaping (UserAPIResponse) -> Void) {
        ChalloLogger.logger.log("Error: \(error as NSObject)")
        let failureResponse = UserAPIResponse(success: false, error: error)
        callback(failureResponse)
        return
    }

    private func handleSuccessResponse(response: JSON,
                                       callback: @escaping (UserAPIResponse) -> Void) {
        guard let certificate = self.parseUser(apiResponse: response) else {
            ChalloLogger.logger.log("Unable to parse api response \(response)")
            let failureResponse = UserAPIResponse(success: false)
            callback(failureResponse)
            return
        }
        let successResponse = UserAPIResponse(success: true, certificate: certificate)
        callback(successResponse)
    }
}
