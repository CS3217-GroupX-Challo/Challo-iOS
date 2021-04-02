//
//  MockGuideAPIResponses.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 21/3/21.
//

import Foundation
@testable import Challo

struct MockGuideAPIResponses: MockAPIResponse {

    typealias JSON = NetworkManager.JSON

    static let userId = UUID(uuidString: "3fa85f64-5717-4562-b3fc-2c963f66afa6") ?? UUID()
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
    static let areaId = UUID(uuidString: "3fa85f64-5717-4562-b3fc-2c963f66afa6") ?? UUID()
    static var area: JSON {
        var json = JSON()
        json[Key.areaId] = areaId.uuidString
        json[Key.village] = "village"
        json[Key.division] = "division3"
        json[Key.state] = "state"
        json[Key.country] = "India"
        return json
    }
    static var areaStruct: Area {
        Area(areaId: areaId,
             village: area[Key.village] as? String ?? "",
             division: area[Key.division] as? String ?? "",
             state: area[Key.state] as? String ?? "",
             country: area[Key.country] as? String ?? "")
    }
    static let rating: Double = 2
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

    static var guideJSONOne: JSON {
        var json = JSON()
        json[Key.phone] = phone
        json[Key.name] = name
        json[Key.email] = email
        json[Key.sex] = sex
        json[Key.profileImage] = profileImg
        json[Key.activeSince] = activeSince
        json[Key.dateJoined] = dateJoined
        json[Key.rating] = "\(rating)"
        json[Key.area] = area
        json[Key.areaId] = areaId.uuidString
        json[Key.dateOfBirth] = dateOfBirth
        json[Key.daysAvailable] = daysAvailable
        json[Key.unavailableDates] = unavailableDates
        json[Key.yearsOfExperience] = yearsOfExperience
        json[Key.languages] = languages
        json[Key.accreditations] = accrediations
        json[Key.memorableExperiences] = memorableExperiences
        json[Key.biography] = biography
        json[Key.userId] = userId.uuidString
        json[Key.nickname] = nickname
        json[Key.hobbies] = hobbies
        return json
    }

    static let userIdTwo = UUID(uuidString: "85e6f125-91be-45f6-bb27-0a3a468a487a") ?? UUID()
    static let nicknameTwo = "nickname2"
    static let biographyTwo = "bio2"
    static let hobbiesTwo = "hobbies2"
    static let memorableExperiencesTwo = "memorableExperiences2"
    static let accrediationsTwo = ["expert trekking"]
    static let languagesTwo = ["English", "Spanish"]
    static let yearsOfExperienceTwo = 3
    static let unavailableDatesTwo = ["2021-03-24"]
    static var unavailableDatesParsedTwo: [Date] {
        unavailableDates.compactMap { Date.construct(with: $0) }
    }
    static let daysAvailableTwo = ["Monday"]
    static let daysAvailableEnumTwo: [Days] = [.Monday]
    static let dateOfBirthTwo = "2021-03-20"
    static let areaIdTwo = UUID(uuidString: "eff7f093-87ed-4eb4-bc01-8adf9a7ac71d") ?? UUID()
    static var areaTwo: JSON {
        var json = JSON()
        json[Key.areaId] = areaIdTwo.uuidString
        json[Key.village] = "villageTwo"
        json[Key.division] = "divisionTwo"
        json[Key.state] = "stateTwo"
        json[Key.country] = "Pakistan"
        return json
    }
    static var areaStructTwo: Area {
        Area(areaId: areaIdTwo,
             village: areaTwo[Key.village] as? String ?? "",
             division: areaTwo[Key.division] as? String ?? "",
             state: areaTwo[Key.state] as? String ?? "",
             country: areaTwo[Key.country] as? String ?? "")
    }
    static let ratingTwo: Double = 2
    static let dateJoinedTwo = "2021-03-21T16:20:08.213Z"
    static var dateJoinedParsedTwo: Date? {
        Date.construct(with: dateJoinedTwo)
    }
    static let activeSinceTwo = "2021-03-21T16:20:08.213Z"
    static var activeSinceParsedTwo: Date? {
        Date.construct(with: activeSinceTwo)
    }
    static let profileImgTwo = "profileImg2"
    static let sexTwo = "female"
    static var sexEnumTwo = Sex.Female
    static let emailTwo = "guide2@example.com"
    static let nameTwo = "Guide2"
    static let phoneTwo = "87654321"

    static var guideJSONTwo: JSON {
        var json = JSON()
        json[Key.phone] = phoneTwo
        json[Key.name] = nameTwo
        json[Key.email] = emailTwo
        json[Key.sex] = sexTwo
        json[Key.profileImage] = profileImgTwo
        json[Key.activeSince] = activeSinceTwo
        json[Key.dateJoined] = dateJoinedTwo
        json[Key.rating] = "\(ratingTwo)"
        json[Key.area] = areaTwo
        json[Key.areaId] = areaIdTwo.uuidString
        json[Key.dateOfBirth] = dateOfBirthTwo
        json[Key.daysAvailable] = daysAvailableTwo
        json[Key.unavailableDates] = unavailableDatesTwo
        json[Key.yearsOfExperience] = yearsOfExperienceTwo
        json[Key.languages] = languagesTwo
        json[Key.accreditations] = accrediationsTwo
        json[Key.memorableExperiences] = memorableExperiencesTwo
        json[Key.biography] = biographyTwo
        json[Key.userId] = userIdTwo.uuidString
        json[Key.nickname] = nicknameTwo
        json[Key.hobbies] = hobbiesTwo
        return json
    }

    static var validResponse: JSON {
        var json = JSON()
        json["message"] = "Guide found"
        json["data"] = [guideJSONOne, guideJSONTwo]
        return json
    }

    static var guideOne: Guide {
        Guide(userId: userId, email: email, profileImg: profileImg, name: name, phone: phone,
              dateJoined: dateJoinedParsed, location: areaStruct, sex: sexEnum,
              rating: rating, daysAvailable: daysAvailableEnum, trails: [],
              unavailableDates: unavailableDatesParsed, yearsOfExperience: yearsOfExperience,
              languages: languages, accreditations: accrediations, biography: biography,
              hobbies: hobbies, memorableExperiences: memorableExperiences)
    }

    static var guideTwo: Guide {
        Guide(userId: userIdTwo, email: emailTwo, profileImg: profileImgTwo, name: nameTwo,
              phone: phoneTwo, dateJoined: dateJoinedParsedTwo, location: areaStructTwo,
              sex: sexEnumTwo, rating: ratingTwo, daysAvailable: daysAvailableEnumTwo, trails: [],
              unavailableDates: unavailableDatesParsedTwo, yearsOfExperience: yearsOfExperienceTwo,
              languages: languagesTwo, accreditations: accrediationsTwo, biography: biographyTwo,
              hobbies: hobbiesTwo, memorableExperiences: memorableExperiencesTwo)
    }

    static var guidesForTrailOne: [Guide] {
        var guide = guideOne
        guide.trails = [MockTrailAPIResponse.trailOne].compactMap { $0 }
        return [guide]
    }
}
