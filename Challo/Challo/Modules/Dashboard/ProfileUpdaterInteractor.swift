//
//  ProfileUpdaterInteractor.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation
import SwiftUI
import Combine

protocol ProfileUpdaterInteractor: ObservableObject {
    associatedtype Presenter: ProfileUpdaterPresenter

    var presenter: Presenter! { get set }
    var userState: UserStateProtocol { get }
    var userAPI: UserAPIProtocol { get }
    var updateUserChat: ((_ name: String, _ email: String) -> Void) { get }

    func validateUserUpdateValues() -> String?

    func updateUser(didUpdateUser: @escaping () -> Void)
    
}

extension ProfileUpdaterInteractor {

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
        guard !body.isEmpty || presenter.inputImage != nil else {
            didUpdateUser()
            return
        }
        updateUserDetails(body: body, didUpdateUser: didUpdateUser)
    }

    private func onUpdateUser(response: UserAPIResponse, didUpdateUser: () -> Void) {
        defer {
            didUpdateUser()
        }
        guard response.success else {
            presenter.errorMessage = UpdateProfileErrorMessages.emailAlreadyTakenErrorMessage
            return
        }
        let certificateManager = CertificateManager(userState: self.userState)
        guard let certificate = response.certificate else {
            self.setFailToUpdateAlert()
            return
        }
        certificateManager.storeCertificate(certificate: certificate)
        self.setUpdateSuccessAlert()
    }

    private func setFailToUpdateAlert(_ message: String? = nil) {
        presenter.isShowingUpdateAlert = true
        presenter.alertMessageTitle = "Failed to update"
        presenter.alertMessageDescription = message ?? "An unexpected error occured"

    }

    private func setUpdateSuccessAlert() {
        presenter.isShowingUpdateAlert = true
        presenter.alertMessageTitle = "Your profile has been updated"
    }

}
