//
//  DashboardInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class TouristDashboardInteractor: InteractorProtocol {

    weak var presenter: TouristDashboardPresenter!

    let bookingsRepository: BookingRepositoryProtocol
    let userState: UserStateProtocol
    let userAPI: UserAPIProtocol
    let updateUserChat: ((_ name: String, _ email: String) -> Void)

    init(bookingsRepository: BookingRepositoryProtocol, userState: UserStateProtocol, userAPI: UserAPIProtocol,
         updateUserChat: @escaping ((_ name: String, _ email: String) -> Void)) {
        self.bookingsRepository = bookingsRepository
        self.userState = userState
        self.userAPI = userAPI
        self.updateUserChat = updateUserChat
    }

    func populateBookings() {
        guard let id = UUID(uuidString: userState.userId) else {
            return
        }
        bookingsRepository.fetchBookingForTouristAndRefresh(id: id, didRefresh: presenter.didPopulateBookings)
    }
}

// MARK: Filter and sort bookings
extension TouristDashboardInteractor {

    func sortBookings(bookings: [Booking]) -> [Booking] {
        bookings.sorted { bookingOne, bookingTwo in
            bookingOne.date < bookingTwo.date
        }
    }

    func filterUpcomingBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            ($0.status == .Paid || $0.status == .Pending) && $0.date > Date()
        }
    }

    func filterPastBookings(bookings: [Booking]) -> [Booking] {
        bookings.filter {
            $0.date < Date()
        }
    }
    
// MARK: Update User Logic
extension TouristDashboardInteractor {
    func validateUserUpdateValues() -> String? {
        guard ValidationUtility.isValidEmail(presenter.editEmail) else {
            return UpdateProfileErrorMessages.invalidEmailErrorMessage
        }
        guard !presenter.editName.isEmpty else {
            return UpdateProfileErrorMessages.invalidNameErrorMessage
        }
        return nil
    }
    
    func updateUser(didUpdateUser: @escaping () -> Void) {
        var body = [String: String]()
        if presenter.editName != userState.name {
            body[Key.name] = presenter.editName
        }
        if presenter.editEmail != userState.email {
            body[Key.email] = presenter.editEmail
        }
        guard !body.isEmpty else {
            didUpdateUser()
            return
        }
        updateUserChat(presenter.editName, presenter.editEmail)
        userAPI.updateUserRequest(userId: userState.userId,
                                  body: body) { [weak self] response in
            self?.onUpdateUser(response: response, didUpdateUser: didUpdateUser)
        }
    }
    
    private func onUpdateUser(response: UserAPIResponse, didUpdateUser: () -> Void) {
        guard response.success else {
            setFailToUpdateAlert()
            return
        }
        let certificateManager = CertificateManager(userState: self.userState)
        guard let certificate = response.certificate else {
            self.setFailToUpdateAlert()
            return
        }
        certificateManager.storeCertificate(certificate: certificate)
        didUpdateUser()
        self.setUpdateSuccessAlert()
    }
    
    private func setFailToUpdateAlert() {
        presenter.isShowingUpdateAlert = true
        presenter.alertMessageTitle = "Failed to update"
        presenter.alertMessageDescription = "An unexpected error occured"
    }

    private func setUpdateSuccessAlert() {
        presenter.isShowingUpdateAlert = true
        presenter.alertMessageTitle = "Your profile has been updated"
    }
}
