//
//  DashboardPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI

class TouristDashboardPresenter: PresenterProtocol, MessagingSupporter {
    
    var router: TouristDashboardRouter?
    var interactor: TouristDashboardInteractor!
    let userState: UserStateProtocol

    var sendMessageToUser: ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)!
    
    @Published var isLoading = false
    @Published var upcomingBookings: [Booking] = []
    @Published var name: String
    @Published var messageText: String = ""
    
    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var isImagePickerOpen = false
    
    init(userState: UserStateProtocol,
         sendMessageToGuide: @escaping ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)) {
        self.userState = userState
        self.name = userState.name
        self.sendMessageToUser = sendMessageToGuide
    }
    
    var displayedProfileImage: Image {
        image ?? (userState.profileImg.isEmpty
                    ? Image("avatar-image")
                    : ImageService.loadImage(path: userState.profileImg))
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
        self.upcomingBookings = filterUpcomingBookings(bookings: bookings)
        isLoading = false
    }

    private func filterUpcomingBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            $0.status == .Paid || $0.status == .Pending
        }
    }
}
