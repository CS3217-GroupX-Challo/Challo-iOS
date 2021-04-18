//
//  GuideDashboardInteractor.swift
//  Challo
//
//  Created by Ying Gao on 1/4/21.
//

import Foundation

class GuideDashboardInteractor: InteractorProtocol {

    weak var presenter: GuideDashboardPresenter!

    let bookingRepository: BookingRepositoryProtocol
    let userState: UserStateProtocol
    let guideAPI: GuideAPIProtocol

    init(userState: UserStateProtocol,
         bookingRepository: BookingRepositoryProtocol,
         guideAPI: GuideAPIProtocol) {
        self.bookingRepository = bookingRepository
        self.userState = userState
        self.guideAPI = guideAPI
    }

    func populateBookings(callback: @escaping ([Booking]) -> Void) {
        guard let uuid = UUID(uuidString: userState.userId) else {
            return
        }
        bookingRepository.fetchBookingForGuideAndRefresh(id: uuid, didRefresh: callback)
    }

    func checkOnboardingStatus() {
        if let guide = userState.user as? Guide {
            presenter.setHasGuideOnboarded(value: hasGuideOnboarded(guide: guide))
            return
        }
        
        guard let id = UUID(uuidString: userState.userId) else {
            fatalError("User should be logged in with a valid UUID")
        }
        
        guideAPI.getGuide(guideId: id) { guide in
            self.presenter.setHasGuideOnboarded(value: self.hasGuideOnboarded(guide: guide))
        }
    }

    private func hasGuideOnboarded(guide: Guide) -> Bool {
        !guide.trails.isEmpty
    }
}
