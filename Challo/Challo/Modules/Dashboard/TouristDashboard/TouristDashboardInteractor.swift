//
//  DashboardInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 30/3/21.
//

import Foundation

class TouristDashboardInteractor: InteractorProtocol {

    weak var presenter: TouristDashboardPresenter!

    let bookingRepository: BookingRepositoryProtocol
    let userState: UserStateProtocol
    let userAPI: UserAPIProtocol
    let updateUserChat: ((_ name: String, _ email: String) -> Void)

    init(bookingRepository: BookingRepositoryProtocol, userState: UserStateProtocol, userAPI: UserAPIProtocol,
         updateUserChat: @escaping ((_ name: String, _ email: String) -> Void)) {
        self.bookingRepository = bookingRepository
        self.userState = userState
        self.userAPI = userAPI
        self.updateUserChat = updateUserChat
    }

    func populateBookings() {
        guard let id = UUID(uuidString: userState.userId) else {
            return
        }
        bookingRepository.fetchBookingForTouristAndRefresh(id: id, didRefresh: presenter.didPopulateBookings)
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
    
    private func extractUpdateUserBody() -> [String: String] {
        var body = [String: String]()
        if presenter.editName != userState.name {
            body[Key.name] = presenter.editName
        }
        if presenter.editEmail != userState.email {
            body[Key.email] = presenter.editEmail
        }
        return body
    }
    
    private func updateUserDetails(body: [String: String], didUpdateUser: @escaping () -> Void) {
        guard let image = presenter.inputImage, let imageData = image.jpegData(compressionQuality: 0.5) else {
            updateUserBasicDetails(body: body, didUpdateUser: didUpdateUser)
            return
        }
        let fileName = "\(userState.userId)_profileImg.jpg"
        ImageService.uploadImage(image: imageData,
                                 fileName: fileName,
                                 onProgress: nil,
                                 onSuccess: { [weak self] actualFileName in
                                    var newBody = body
                                    newBody[Key.profileImage] = actualFileName
                                    self?.updateUserBasicDetails(body: newBody, didUpdateUser: didUpdateUser)
                                 },
                                 onFailure: { [weak self] error in
                                    ChalloLogger.logger.error("\(error.localizedDescription)")
                                    self?.setFailToUpdateAlert()
                                    didUpdateUser()
                                 })
    }
    
    private func updateUserBasicDetails(body: [String: String], didUpdateUser: @escaping () -> Void) {
        userAPI.updateUserRequest(userId: userState.userId,
                                  body: body) { [weak self] response in
            self?.onUpdateUser(response: response, didUpdateUser: {
                guard let self = self else {
                    return
                }
                self.updateUserChat(self.presenter.editName, self.presenter.editEmail)
                didUpdateUser()
            })
        }
    }
    
    func updateUser(didUpdateUser: @escaping () -> Void) {
        let body = extractUpdateUserBody()
        guard !body.isEmpty else {
            didUpdateUser()
            return
        }
        updateUserDetails(body: body, didUpdateUser: didUpdateUser)
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
