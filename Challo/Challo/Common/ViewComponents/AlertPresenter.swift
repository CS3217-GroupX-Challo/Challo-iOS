//
//  AlertPresenter.swift
//  Challo
//
//  Created by Tan Le Yang on 12/4/21.
//

protocol AlertPresenter: AnyObject {

    var isSuccessAlert: Bool { get set }
    var isShowingAlert: Bool { get set }
    var alertTitle: String { get set }
    var alertMessage: String { get set }

    func presentFailureAlert(title: String, message: String)
    func presentSuccessAlert(title: String, message: String)
}

extension AlertPresenter {

    func presentFailureAlert(title: String, message: String) {
        self.isSuccessAlert = false
        self.alertTitle = title
        self.alertMessage = message
        self.isShowingAlert = true
    }

    func presentSuccessAlert(title: String, message: String) {
        self.isSuccessAlert = true
        self.alertTitle = title
        self.alertMessage = message
        self.isShowingAlert = true
    }
}
