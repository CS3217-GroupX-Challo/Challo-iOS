//
//  OnboardingAPI.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

protocol OnboardingAPI: AnyObject {

    typealias JSON = NetworkManager.JSON
    var networkManager: NetworkManager { get }
    var url: String { get }
    var userId: String { get }

    func updateParticulars(uuid: String, body: JSON, responseHandler: @escaping (JSON, Error?) -> Void)

}

extension OnboardingAPI {

    func updateParticulars(uuid: String, body: JSON, responseHandler: @escaping (JSON, Error?) -> Void) {
        let guideUrl = url + "/" + userId
        networkManager.put(url: guideUrl,
                           headers: NetworkManager.HEADER(),
                           body: body) { response, error in
            responseHandler(response, error)
        }
    }

}
