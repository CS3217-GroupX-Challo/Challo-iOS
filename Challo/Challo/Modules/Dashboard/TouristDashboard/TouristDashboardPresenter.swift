//
//  DashboardPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI
import Combine

class TouristDashboardPresenter: PresenterProtocol {
    
    var router: TouristDashboardRouter?
    var interactor: TouristDashboardInteractor!
    let userState: UserStateProtocol

    let sendMessageToGuide: ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)
    
    @Published var isLoading = false
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
        self.editName = userState.name
        self.editEmail = userState.email
        self.sendMessageToGuide = sendMessageToGuide
        setupUserStateSubscriber(userState: userState)
    }
    
    var isUpdateSaveButtonDisabled: Bool {
        editName == userState.name && editEmail == userState.email && inputImage == nil
    }
    
    var profileImgPath: String {
        userState.profileImg
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
        self.name = userState.name
        populateBookings()
    }
    
    func populateBookings() {
        isLoading = true
        interactor.populateBookings()
    }

    func didPopulateBookings(bookings: [Booking]) {
        let sortedBookings = interactor.sortBookings(bookings: bookings)
        self.upcomingBookings = interactor.filterUpcomingBookings(bookings: sortedBookings)
        self.pastBookings = interactor.filterPastBookings(bookings: sortedBookings)
        isLoading = false
    }

    func getReviewPage(for booking: Booking) -> AnyView? {
        router?.getReviewPage(for: booking)
    }
    
    func onTapSendMessage(guide: Guide) {
        sendMessageToGuide(guide.email, guide.userId, messageText)
        messageText = ""
    }
    
    func onTapSave() {
        isSaving = true
        errorMessage = interactor.validateUserUpdateValues()
        guard errorMessage == nil else {
            isSaving = false
            return
        }
        interactor.updateUser { [weak self] in
            self?.isSaving = false
        }
    }
    
    func onCloseAlert() {
        alertMessageTitle = ""
        alertMessageDescription = ""
    }
}

// MARK: Handle Bookings
extension TouristDashboardPresenter {

    private func sortBookings(bookings: [Booking]) -> [Booking] {
        bookings.sorted { bookingOne, bookingTwo in
            bookingOne.date < bookingTwo.date
        }
    }

    private func filterUpcomingBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            ($0.status == .Paid || $0.status == .Pending) && $0.date > Date()
        }
    }

    private func filterPastBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            $0.date < Date()
        }
    }
}

enum TouristDashboardTabs: String, CaseIterable {
    case upcomingBookings = "Upcoming Bookings"
    case pastBookings = "Past Bookings"
}
