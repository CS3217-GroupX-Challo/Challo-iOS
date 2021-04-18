//
//  GuideOnboardingAPI.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

class GuideOnboardingAPI: OnboardingAPI {

    let networkManager = APINetwork.getNetworkManager()
    let guideAPI: GuideAPIProtocol
    let guideParser = GuideAPIParser()
    let url = "/guide"
    let userState: UserStateProtocol

    init(userState: UserStateProtocol, guideAPI: GuideAPIProtocol) {
        self.userState = userState
        self.guideAPI = guideAPI
    }

    var userId: String {
        userState.userId
    }

    func updateGuideParticulars(details: GuideOnboardingDetails, responseHandler: @escaping (JSON, Error?) -> Void) {
        guard let guide = userState.user as? Guide else {
            getGuideFromAPIAndUpdate(details: details, responseHandler: responseHandler)
            return
        }
        updateGuide(guide: guide, details: details, responseHandler: responseHandler)
    }

    private func getGuideFromAPIAndUpdate(details: GuideOnboardingDetails,
                                          responseHandler: @escaping (JSON, Error?) -> Void) {
        guard let uuid = UUID(uuidString: userState.userId) else {
            fatalError("User should have been logged in already")
        }
        guideAPI.getGuide(guideId: uuid) { [weak self] guide in
            self?.updateGuide(guide: guide, details: details, responseHandler: responseHandler)
        }
    }

    private func updateGuide(guide: Guide, details: GuideOnboardingDetails,
                             responseHandler: @escaping (JSON, Error?) -> Void) {
        let guideJSON = guideParser.convertGuideToJSON(guide: guide)
        let body = details.convertToGuideDetailsJSON(guideJSON: guideJSON)
        let trailJSON = details.trailJSON
        self.networkManager.put(url: "/guide/trail/\(userId)",
                                headers: [String: String](),
                                body: trailJSON) { _, _ in
            self.updateParticulars(uuid: self.userId,
                                   body: body,
                                   responseHandler: responseHandler)
        }
    }
}
