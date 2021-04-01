import SwiftUI

protocol RegisterPresenter: AnyObject {

    var interactor: RegisterInteractor! { get set }
    var router: RegisterRouter? { get set }
    var name: String { get set }
    var phone: String { get set }
    var email: String { get set }
    var password: String { get set }
    var isShowingRegisterAlert: Bool { get set }
    var registerAlertTitle: String { get set }
    var registerAlertMessage: String { get set }

    func submitRegistration()
    func showRegisterFailureAlert()
    
}

extension RegisterPresenter {

    func submitRegistration() {
        let registrationDetails = RegistrationDetails(name: name,
                                                      phone: phone,
                                                      email: email,
                                                      password: password)
        interactor.register(details: registrationDetails)
    }

    func showRegisterFailureAlert() {
        self.isShowingRegisterAlert = true
        self.registerAlertTitle = "Failed to register"
        self.registerAlertMessage = "Please check your details again"
    }

    func showRegisterSuccessAlert() {
        self.isShowingRegisterAlert = true
        self.registerAlertTitle = "Registration successful!"
        self.registerAlertMessage = "You may now sign in with your account"
    }
}
