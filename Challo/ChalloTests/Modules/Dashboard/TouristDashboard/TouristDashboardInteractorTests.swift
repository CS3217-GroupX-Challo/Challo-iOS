//
//  TouristDashboardInteractorTests.swift
//  ChalloTests
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation
import XCTest
@testable import Challo

class TouristDashboardInteractorTests: XCTestCase {
    
    func testPopulateBookings_withMockAPI_presenterBookingsPopulatedWithSameBookingsRetrievedFromAPI() {
        let userState = MockUserState.createMockLoggedInUserState()
        let interactor = TouristDashboardInteractor(bookingsRepository: MockBookingRepository(),
                                                    userState: userState)
        let presenter = TouristDashboardPresenter(userState: userState, sendMessageToGuide: { _, _, _ in })
        interactor.presenter = presenter
        interactor.populateBookings()
        
        XCTAssertEqual(MockBookingAPIResponses.bookings, presenter.upcomingBookings)
    }
}
