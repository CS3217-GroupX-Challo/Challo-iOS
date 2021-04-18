//
//  ProfileUpdaterPresenter.swift
//  Challo
//
//  Created by Ying Gao on 18/4/21.
//

import Foundation
import SwiftUI
import Combine

protocol ProfileUpdaterPresenter: ObservableObject {
    associatedtype Interactor: ProfileUpdaterInteractor

    var interactor: Interactor! { get set }

    var userState: UserStateProtocol { get }

    var image: Image? { get set }
    var inputImage: UIImage? { get set }

    var editName: String { get set }
    var editEmail: String { get set }
    var isSaving: Bool { get set }
    var errorMessage: String? { get set }

    var isShowingUpdateAlert: Bool { get set }
    var alertMessageTitle: String { get set }
    var alertMessageDescription: String { get set }

    func onTapSave()

    func onCloseAlert()

    func onOpenUpdateProfilePage()

    var isUpdateSaveButtonDisabled: Bool { get }

}

extension ProfileUpdaterPresenter {
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

    func onOpenUpdateProfilePage() {
        inputImage = nil
        image = nil
        editName = userState.name
        editEmail = userState.email
        errorMessage = nil
    }

    var isUpdateSaveButtonDisabled: Bool {
        editName == userState.name && editEmail == userState.email && inputImage == nil
    }
}
