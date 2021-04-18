//
//  GuideOnboardingAPI.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

class GuideOnboardingAPI: OnboardingAPI {

    let networkManager = APINetwork.getNetworkManager()
    let guideParser = GuideAPIParser()
    let url = "/guide/"
    let userState: UserStateProtocol

    init(userState: UserStateProtocol) {
        self.userState = userState
    }

    var userId: String {
        userState.userId
    }

    func updateGuideParticulars(details: GuideOnboardingDetails, responseHandler: @escaping (JSON, Error?) -> Void) {
        guard let guide = userState.user as? Guide else {
            return
        }
        let guideJSON = guideParser.convertGuideToJSON(guide: guide)
        let body = details.convertToGuideDetailsJSON(guideJSON: guideJSON)
        updateParticulars(uuid: userId, body: body, responseHandler: responseHandler)
    }

}
