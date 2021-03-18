import SwiftUI

protocol RegisterPresenter: AnyObject {

    var interactor: RegisterInteractor! { get set }
    var router: RegisterRouter? { get set }
    var name: String { get set }
    var phone: String { get set }
    var email: String { get set }
    var password: String { get set }
    var isShowingRegisterFailureAlert: Bool { get set }

    func makeRegisterButton() -> AnyView
    func submitRegistration()
    func showRegisterFailureAlert()
}

extension RegisterPresenter {

    func makeRegisterButton() -> AnyView {
        AnyView(Button(action: submitRegistration, label: {
            Text("SIGN UP")
                .bold()
        }).buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeForeground)))
    }

    func submitRegistration() {
        let registrationDetails = RegistrationDetails(name: name,
                                                      phone: phone,
                                                      email: email,
                                                      password: password)
        interactor.register(details: registrationDetails)
    }

    func showRegisterFailureAlert() {
        self.isShowingRegisterFailureAlert = true
    }
}
