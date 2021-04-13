//
//  GuideOnboardingDetails.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

struct GuideOnboardingDetails {
    var nickname: String
    var dateOfBirth: Date
    var languages: [String]
    var yearsOfExperience: Int
    var hobbies: String
    var accreditations: [String]
    var area: Area
    var biography: String
    var trails: String
    var daysAvailable: [Days]
}

extension GuideOnboardingDetails {

    typealias JSON = NetworkManager.JSON

    func convertToJSON(areaParser: AreaAPIParser) -> JSON {
        var json = JSON()
        json[Key.nickname] = nickname
        json[Key.dateOfBirth] = dateOfBirth.destruct()
        json[Key.languages] = languages
        json[Key.yearsOfExperience] = yearsOfExperience
        json[Key.hobbies] = hobbies
        json[Key.accreditations] = accreditations
        json[Key.area] = areaParser.convertAreaToJSON(area: area)
        json[Key.biography] = biography
        json[Key.daysAvailable] = daysAvailable
        return json
    }

}
