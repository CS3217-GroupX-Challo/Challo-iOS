//
//  GuideDashboardPresenter.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation
import SwiftUI
import Combine

class GuideDashboardPresenter: PresenterProtocol, ProfileImageProvider {
    var interactor: GuideDashboardInteractor!
    var router: GuideDashboardRouter?

    let userState: UserStateProtocol
    private(set) var name: String

    init(userState: UserStateProtocol,
         sendMessageToTourist: @escaping (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void,
         bookingRepository: BookingRepositoryProtocol) {
        self.userState = userState
        self.name = userState.name
        self.sendMessageToTourist = sendMessageToTourist
        self.bookingRepository = bookingRepository
        setupUserStateSubscriber()
    }

    // MARK: Subscriber

    private var cancellables = Set<AnyCancellable>()

    private func setupUserStateSubscriber() {
        guard let userState = userState as? UserState else {
            return
        }
        userState.$user.sink { user in
            guard let user = user, let userName = user.name else {
                return
            }
            self.name = userName
            self.objectWillChange.send()
        }.store(in: &cancellables)
    }

    // MARK: Image picking properties

    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var isImagePickerOpen = false

    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }

    // MARK: Tab selection

    private static let tabs = GuideDashboardTabs.allCases
    let tabs = GuideDashboardTabs.allCases.map { $0.rawValue }
    @Published var selectedIndex = 0 {
        didSet {
            selectedTab = Self.tabs[selectedIndex]
        }
    }
    @Published var selectedTab = tabs[0]

    // MARK: Properties for submodules

    let sendMessageToTourist: (_ touristEmail: String, _ touristId: UUID, _ messageText: String) -> Void
    let bookingRepository: BookingRepositoryProtocol
}

enum GuideDashboardTabs: String, CaseIterable {
    case earnings = "Earning History"
    case upcomingBookings = "Upcoming Bookings"
}
