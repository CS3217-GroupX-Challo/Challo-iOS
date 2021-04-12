//
//  UserAPI.swift
//  Challo
//
//  Created by Tan Le Yang on 20/3/21.
//

import Foundation

class UserAPI: UserAPIProtocol {
    typealias JSON = NetworkManager.JSON
    private static let userPath = "/user"
    private let loginUrl = "\(userPath)/login"
    private let registerUrl = "\(userPath)/register"
    
    private let networkManager: NetworkManager
    private let userParser: UserAPIParser
   
    init(userParser: UserAPIParser, networkManager: NetworkManager) {
        self.userParser = userParser
        self.networkManager = networkManager
    }
    
    func commonLogin(credentials: JSON,
                     callback: @escaping (UserAPIResponse) -> Void) {
        sendUserPostRequest(url: loginUrl,
                            body: credentials,
                            callback: callback)
    }

    func commonRegister(details: JSON,
                        callback: @escaping (UserAPIResponse) -> Void) {
        sendUserPostRequest(url: registerUrl,
                            body: details,
                            callback: callback)
    }
}

extension UserAPI {

    func sendUserPostRequest(url: String,
                             body: JSON,
                             callback: @escaping (UserAPIResponse) -> Void) {
        networkManager.post(url: url,
                            headers: NetworkManager.HEADER(),
                            body: body) { [weak self] res, err in
            if let err = err {
                self?.handleErrorResponse(error: err, callback: callback)
                return
            }
            self?.handleSuccessResponse(response: res, callback: callback)
        }
    }
    
    func updateUserRequest(userId: String,
                           body: JSON,
                           callback: @escaping (UserAPIResponse) -> Void) {
        networkManager.put(url: "\(UserAPI.userPath)/\(userId)",
                           headers: NetworkManager.HEADER(),
                           body: body) { [weak self] res, err in
            if let err = err {
                self?.handleErrorResponse(error: err, callback: callback)
                return
            }
            self?.handleSuccessResponse(response: res, callback: callback)
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
        guard let certificate = userParser.parseUser(apiResponse: response) else {
            ChalloLogger.logger.log("Unable to parse api response \(response)")
            let failureResponse = UserAPIResponse(success: false)
            callback(failureResponse)
            return
        }
        let successResponse = UserAPIResponse(success: true, certificate: certificate)
        callback(successResponse)
    }
}
