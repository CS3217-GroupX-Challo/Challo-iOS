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
    let userId: String

    init(userState: UserStateProtocol) {
        self.userId = userState.userId
    }

    func updateGuideParticulars(details: GuideOnboardingDetails) {
        let body = details.convertToJSON(areaParser: areaParser)
        updateParticulars(uuid: userId, body: body)
    }

}
