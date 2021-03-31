//
//  MockReviewAPIResponse.swift
//  ChalloTests
//
//  Created by Kester Ng on 21/3/21.
//

@testable import Challo
import Foundation

struct MockReviewAPIResponse: MockAPIResponse {
    typealias JSON = NetworkManager.JSON
    
    static let reviewIdOne = UUID(uuidString: "ab4633c9-8c28-4c97-934c-3963d0bf02fa") ?? UUID()
    static let ratingOne: String = "3"
    static let guideIdOne = UUID(uuidString: "5e34b776-cae1-42ac-8a60-d74a8cd0798e") ?? UUID()
    static let touristIdOne = UUID(uuidString: "efecd96d-b46f-4152-9963-9a6df8abec14") ?? UUID()
    static let trailIdOne = UUID(uuidString: "e26fc1aa-e82e-4098-86d6-f9c07af70899") ?? UUID()
    static let commentOne: String = "Best guide ever!"
    static let createAtOneString: String = "2021-03-20T18:52:50.741Z"
    static let createdAtOne: Date? = Date.construct(with: createAtOneString)
    
    static var reviewJSONOne: JSON {
        var json = JSON()
        json[Key.reviewId] = reviewIdOne.uuidString
        json[Key.rating] = ratingOne
        json[Key.guideId] = guideIdOne.uuidString
        json[Key.trailId] = trailIdOne.uuidString
        json[Key.touristId] = touristIdOne.uuidString
        json[Key.comment] = commentOne
        json[Key.createdAt] = createAtOneString
        return json
    }
    
    static var reviewStateOne: ReviewState {
        ReviewState(reviewId: reviewIdOne, rating: Int(ratingOne) ?? 3, comment: commentOne,
                    guideId: guideIdOne, touristId: touristIdOne,
                    trailId: trailIdOne, createdAt: createdAtOne)
    }
    
    static let reviewIdTwo = UUID(uuidString: "eff7f093-87ed-4eb4-bc01-8adf9a7ac71d") ?? UUID()
    static let ratingTwo: String = "5"
    static let guideIdTwo = UUID(uuidString: "15f5b387-3bfb-4bf4-93c9-e13ee5ec0c12") ?? UUID()
    static let touristIdTwo = UUID(uuidString: "efecd96d-b46f-4152-9963-9a6df8abec14") ?? UUID()
    static let trailIdTwo = UUID(uuidString: "aa76f93c-d1a6-4eec-8551-ecc6f8994b5c") ?? UUID()
    static let commentTwo: String = "Best guide ever! Please vote for him!"
    static let createdAtTwoString: String = "2021-03-20T18:52:50.741Z"
    static let createdAtTwo: Date? = Date.construct(with: createdAtTwoString)
    
    static var reviewJSONTwo: JSON {
        var json = JSON()
        json[Key.reviewId] = reviewIdTwo.uuidString
        json[Key.rating] = ratingTwo
        json[Key.guideId] = guideIdTwo.uuidString
        json[Key.trailId] = trailIdTwo.uuidString
        json[Key.touristId] = touristIdTwo.uuidString
        json[Key.comment] = commentTwo
        json[Key.createdAt] = createdAtTwoString
        return json
    }
    
    static var reviewStateTwo: ReviewState {
        ReviewState(reviewId: reviewIdTwo, rating: Int(ratingTwo) ?? 5, comment: commentTwo,
                    guideId: guideIdTwo, touristId: touristIdTwo,
                    trailId: trailIdTwo, createdAt: createdAtTwo)
    }
    
    static var response: JSON {
        var json = JSON()
        json["message"] = "Review successfully retrieved"
        json["data"] = [reviewJSONOne, reviewJSONTwo]
        return json
    }
}
