//
//  GuideOnboardingDetails.swift
//  Challo
//
//  Created by Ying Gao on 13/4/21.
//

import Foundation

struct GuideOnboardingDetails {
    var userId: UUID
    var nickname: String
    var dateOfBirth: Date
    var languages: [Languages]
    var yearsOfExperience: Int
    var hobbies: String
    var accreditations: [String]
    var biography: String
    var trails: [Trail]
    var daysAvailable: [Days]
}

extension GuideOnboardingDetails {

    typealias JSON = NetworkManager.JSON

    func convertToGuideDetailsJSON(areaParser: AreaAPIParser) -> JSON {
        var json = JSON()
        json[Key.nickname] = nickname
        json[Key.dateOfBirth] = dateOfBirth.destruct()
        json[Key.languages] = languages.map { $0.rawValue }
        json[Key.yearsOfExperience] = yearsOfExperience
        json[Key.hobbies] = hobbies
        json[Key.accreditations] = accreditations
        json[Key.biography] = biography
        json[Key.daysAvailable] = daysAvailable.map { $0.rawValue }
        return json
    }

}
