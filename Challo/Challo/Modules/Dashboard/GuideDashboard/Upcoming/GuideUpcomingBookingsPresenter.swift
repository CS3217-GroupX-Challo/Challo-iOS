//
//  GuideUpcomingBookingsPresenter.swift
//  Challo
//
//  Created by Ying Gao on 12/4/21.
//

import Foundation
import SwiftUI

class GuideUpcomingBookingsPresenter: PresenterProtocol {

    var interactor: GuideUpcomingBookingsInteractor!
    var router: GuideUpcomingBookingsRouter?

    let userState: UserStateProtocol
    let sendMessageToTourist: (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void

    @Published var loading = false

    @Published var upcomingBookings: [Booking] = []

    @Published var name: String

    init(userState: UserStateProtocol,
         sendMessageToTourist: @escaping ((_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void)) {
        self.userState = userState
        self.name = userState.name
        self.sendMessageToTourist = sendMessageToTourist
    }

    @Published var image: Image?

    var displayedProfileImage: Image {
        image ?? (userState.profileImg.isEmpty
                    ? Image("avatar-image")
                    : ImageService.loadImage(path: userState.profileImg))
    }

    func didPopulateBookings(bookings: [Booking]) {
        upcomingBookings = bookings.filter { $0.status == .Pending || $0.status == .Paid }
        loading = false
    }

    func refresh() {
        loading = true
        name = userState.name
        interactor.populateBookings(callback: didPopulateBookings(bookings:))
    }
}
