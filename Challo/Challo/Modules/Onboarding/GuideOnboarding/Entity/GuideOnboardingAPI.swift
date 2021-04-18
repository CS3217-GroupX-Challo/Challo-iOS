//
//  GuideOnboardingAPI.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

class GuideOnboardingAPI: OnboardingAPI {

    let networkManager = APINetwork.getNetworkManager()
    let areaParser = AreaAPIParser()
    let url = "/guide/"
    let userState: UserStateProtocol

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    var userId: String {
        userState.userId
    }

    func updateGuideParticulars(details: GuideOnboardingDetails, responseHandler: @escaping (JSON, Error?) -> Void) {
        guard UUID(uuidString: userId) != nil else {
            fatalError("User should have been logged in with valid UUID already")
        }
        let body = details.convertToGuideDetailsJSON(areaParser: areaParser)
        updateParticulars(uuid: userId, body: body, responseHandler: responseHandler)
    }

}
