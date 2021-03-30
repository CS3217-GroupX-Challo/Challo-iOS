//
//  MockReviewAPIParser.swift
//  ChalloTests
//
//  Created by Kester Ng on 27/3/21.
//

@testable import Challo

class MockReviewAPIParser: ReviewAPIParser {
    override func parseReviews(response: ReviewAPIParser.JSON) -> [ReviewState] {
        []
    }
}
