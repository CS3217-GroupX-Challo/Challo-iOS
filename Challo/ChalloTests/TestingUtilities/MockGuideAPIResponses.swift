//
//  MockGuideAPIResponses.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

import Foundation
@testable import Challo

struct MockGuideAPIResponses {

    typealias JSON = NetworkManager.JSON

    static let userUUID = UUID(uuidString: userId)!
    static let userId = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
    static let nickname = "nickname"
    static let biography = "bio"
    static let hobbies = "hobbies"
    static let memorableExperiences = "memorableExperiences"
    static let accrediations = ["life saving", "trekking 101"]
    static let languages = ["English"]
    static let yearsOfExperience = 0
    static let unavailableDates = ["2021-03-20"]
    static var unavailableDatesParsed: [Date] {
        unavailableDates.compactMap { Date.construct(with: $0) }
    }
    static let daysAvailable = ["Monday"]
    static let daysAvailableEnum: [Days] = [.Monday]
    static let dateOfBirth = "2021-03-20"
    static let areaId = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
    static let areaUUID = UUID(uuidString: areaId)!
    static var area: JSON {
        var json = JSON()
        json[Key.areaId] = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
        json[Key.village] = "village"
        json[Key.division] = "division3"
        json[Key.state] = "state"
        json[Key.country] = "India"
        return json
    }
    static var areaStruct: Area {
        Area(areaId: areaUUID,
             areaName: area[Key.state] as? String ?? "",
             regionName: area[Key.country] as? String ?? "")
    }
    static let rating: Decimal = 2
    static let dateJoined = "2021-03-20T16:20:08.213Z"
    static var dateJoinedParsed: Date? {
        Date.construct(with: dateJoined)
    }
    static let activeSince = "2021-03-20T16:20:08.213Z"
    static var activeSinceParsed: Date? {
        Date.construct(with: activeSince)
    }
    static let profileImg = "profileImg"
    static let sex = "male"
    static var sexEnum = Sex.Male
    static let email = "guide@example.com"
    static let name = "Guide"
    static let phone = "12345678"

    static var validJSON: JSON {
        var json = JSON()
        json[Key.phone] = phone
        json[Key.name] = name
        json[Key.email] = email
        json[Key.sex] = sex
        json[Key.profileImage] = profileImg
        json[Key.activeSince] = activeSince
        json[Key.dateJoined] = dateJoined
        json[Key.rating] = rating
        json[Key.area] = area
        json[Key.areaId] = areaId
        json[Key.dateOfBirth] = dateOfBirth
        json[Key.daysAvailable] = daysAvailable
        json[Key.unavailableDates] = unavailableDates
        json[Key.yearsOfExperience] = yearsOfExperience
        json[Key.languages] = languages
        json[Key.accreditations] = accrediations
        json[Key.memorableExperiences] = memorableExperiences
        json[Key.biography] = biography
        json[Key.userId] = userId
        json[Key.nickname] = nickname
        json[Key.hobbies] = hobbies
        return json
    }

    static var expectedGuide: Guide {
        Guide(userId: userUUID, email: email, profileImg: profileImg, name: name, phone: phone,
              dateJoined: dateJoinedParsed, location: areaStruct, sex: sexEnum,
              rating: rating, daysAvailable: daysAvailableEnum, trails: [],
              unavailableDates: unavailableDatesParsed, yearsOfExperience: yearsOfExperience,
              languages: languages, accreditations: accrediations, biography: biography,
              hobbies: hobbies, memorableExperiences: memorableExperiences)
    }
}
