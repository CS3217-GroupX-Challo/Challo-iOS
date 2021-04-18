//
//  DashboardPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI
import Combine

class TouristDashboardPresenter: PresenterProtocol, MessagingSupporter, ProfileImageProvider {
    
    var router: TouristDashboardRouter?
    var interactor: TouristDashboardInteractor!
    let userState: UserStateProtocol

    var sendMessageToUser: ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)!
    
    @Published var isLoading = false
    @Published var isRefreshing = false {
        didSet {
            if isRefreshing == true {
                populateBookings()
            }
        }
    }
    
    @Published var upcomingBookings: [Booking] = []
    @Published var pastBookings: [Booking] = []
    
    @Published var name: String
    @Published var messageText: String = ""

    private static let tabs = TouristDashboardTabs.allCases
    let tabTitles = tabs.map { $0.rawValue }
    @Published var selectedIdx = 0 {
        didSet {
            selectedTab = Self.tabs[selectedIdx]
        }
    }
    @Published var selectedTab: TouristDashboardTabs = tabs[0]
    
    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var isImagePickerOpen = false
    
    @Published var editName = ""
    @Published var editEmail = ""
    @Published var isSaving = false
    @Published var errorMessage: String?
    
    @Published var isShowingUpdateAlert = false
    @Published var alertMessageTitle = ""
    @Published var alertMessageDescription = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(userState: UserStateProtocol,
         sendMessageToGuide: @escaping ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)) {
        self.userState = userState
        self.name = userState.name
        self.sendMessageToUser = sendMessageToGuide
        self.editName = userState.name
        self.editEmail = userState.email
        setupUserStateSubscriber(userState: userState)
    }
    
    private func setupUserStateSubscriber(userState: UserStateProtocol) {
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
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }

    func refresh() {
        self.isLoading = true
        self.name = userState.name
        interactor.initialFetch()
        handleBookings(bookings: interactor.getCachedEntities())
    }
    
    func populateBookings() {
        interactor.getAllEntities()
    }

    func didPopulateBookings(bookings: [Booking]) {
        handleBookings(bookings: bookings)
        isLoading = false
        isRefreshing = false
    }

    func getReviewPage(for booking: Booking) -> AnyView? {
        router?.getReviewPage(for: booking)
    }

}

// MARK: Logic for updating user state
extension TouristDashboardPresenter: ProfileUpdaterPresenter { }

// MARK: Handle Bookings
extension TouristDashboardPresenter {

    private func handleBookings(bookings: [Booking]) {
        let sortedBookings = interactor.sortBookings(bookings: bookings)
        self.upcomingBookings = interactor.filterUpcomingBookings(bookings: sortedBookings)
        self.pastBookings = interactor.filterPastBookings(bookings: sortedBookings)
    }
}

enum TouristDashboardTabs: String, CaseIterable {
    case upcomingBookings = "Upcoming Bookings"
    case pastBookings = "Past Bookings"
}
