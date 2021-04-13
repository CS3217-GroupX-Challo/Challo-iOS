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

    func updateParticulars(url: String, uuid: String, body: JSON) {
        networkManager.put(url: url,
                           headers: NetworkManager.HEADER(),
                           body: body) { _, error in
            if let error = error {
                ChalloLogger.logger.log("Could not update guide details: \(error as NSObject)")
            }
        }
    }

    func createGuideJSON(details: GuideOnboardingDetails) -> JSON {
        var json = JSON()
        json[Key.nickname] = details.nickname
        json[Key.dateOfBirth] = details.dateOfBirth
        json[Key.languages] = details.languages
        json[Key.yearsOfExperience] = details.yearsOfExperience
        json[Key.hobbies] = details.hobbies
        json[Key.accreditations] = details.accreditations
        json[Key.area] = areaParser.convertAreaToJSON(area: details.area)
        json[Key.biography] = details.biography
        json[Key.daysAvailable] = details.daysAvailable
        return json
    }

}
