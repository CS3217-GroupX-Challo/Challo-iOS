//
//  TrailBookingInteractorTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 31/3/21.
//

@testable import Challo
import XCTest
import Foundation

class TrailBookingInteractorTests: XCTestCase {

    private let bookingForm = TrailBookingForm(guideId: MockGuideAPIResponses.userId,
                                               trailId: MockTrailAPIResponse.trailIdOne,
                                               date: Date(),
                                               numberOfPax: 2,
                                               totalFee: 1_000)

    func testGetGuidesForTrail_validTrailId_correctGuidesReturned() {
        let interactor = createInteractor()
        let trailId = MockTrailAPIResponse.trailIdOne
        interactor.getGuidesForTrail(trailId: trailId) { guides in
            XCTAssertEqual(MockGuideAPIResponses.guidesForTrailOne, guides)
        }
    }

    func testGetGuidesForTrail_noGuidesForTrail_noGuidesReturned() {
        let interactor = createInteractor()
        let trailId = MockTrailAPIResponse.trailIdTwo
        interactor.getGuidesForTrail(trailId: trailId) { guides in
            XCTAssertTrue(guides.isEmpty)
        }
    }

    func testGetGuidesForTrail_invalidTrailId_noGuidesReturned() {
        let interactor = createInteractor()
        let trailId = UUID()
        interactor.getGuidesForTrail(trailId: trailId) { guides in
            XCTAssertTrue(guides.isEmpty)
        }
    }

    func testMakeBooking_successBooking_successCallback() {
        let interactor = createInteractor()
        interactor.makeBooking(bookingForm: bookingForm) { success, err in
            XCTAssertTrue(success)
            XCTAssertNil(err)
        }
    }

    func testMakeBooking_userStateNotSignedIn_failureCallback() {
        let interactor = createNonLoggedInStateInteractor()
        interactor.makeBooking(bookingForm: bookingForm) { success, _ in
            XCTAssertFalse(success)
        }
    }
}

extension TrailBookingInteractorTests {

    private func createInteractor() -> TrailBookingInteractor {
        let guideAPI = MockGuideAPI(mockGuides: MockGuideAPIResponses.guidesForTrailOne)
        let guideRepo = MockGuideRepository(guideAPI: guideAPI)
        return TrailBookingInteractor(trailRepository: MockTrailRepository(),
                                      guideRepository: guideRepo,
                                      bookingAPI: MockBookingAPI(),
                                      userState: MockUserState.createMockLoggedInUserState())
    }

    private func createNonLoggedInStateInteractor() -> TrailBookingInteractor {
        let guideAPI = MockGuideAPI(mockGuides: MockGuideAPIResponses.guidesForTrailOne)
        let guideRepo = MockGuideRepository(guideAPI: guideAPI)
        return TrailBookingInteractor(trailRepository: MockTrailRepository(),
                                      guideRepository: guideRepo,
                                      bookingAPI: MockBookingAPI(),
                                      userState: MockUserState())
    }
}
