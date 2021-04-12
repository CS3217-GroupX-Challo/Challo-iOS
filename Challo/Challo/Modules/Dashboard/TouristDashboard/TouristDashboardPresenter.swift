//
//  DashboardPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import SwiftUI

class TouristDashboardPresenter: PresenterProtocol {
    
    var router: TouristDashboardRouter?
    var interactor: TouristDashboardInteractor!
    unowned let userState: UserStateProtocol!

    let sendMessageToGuide: ((_ guideEmail: String, _ guideId: UUID, _ messageText: String) -> Void)
    
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
        self.sendMessageToGuide = sendMessageToGuide
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
    
    func onTapSendMessage(guide: Guide) {
        sendMessageToGuide(guide.email, guide.userId, messageText)
        messageText = ""
    }
}
