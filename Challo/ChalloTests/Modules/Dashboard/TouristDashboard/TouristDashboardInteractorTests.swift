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
        let userAPI = MockUserAPI()
        let interactor = TouristDashboardInteractor(bookingsRepository: MockBookingRepository(),
                                                    userState: userState,
                                                    userAPI: userAPI,
                                                    updateUserChat: { _, _ in })
        let presenter = TouristDashboardPresenter(userState: userState, sendMessageToGuide: { _, _, _ in })
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.populateBookings()
        let expected = MockBookingAPIResponses
                        .bookings.filter { $0.status != .Completed }
        XCTAssertEqual(expected, presenter.upcomingBookings)
    }
}
