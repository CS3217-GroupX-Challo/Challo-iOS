import SwiftUI

class RegisterPresenter: PresenterProtocol {

    var interactor: RegisterInteractor!
    var router: RegisterRouter?

    @Published var name = ""
    @Published var phone = ""
    @Published var email = ""
    @Published var password = ""

    func makeRegisterButton() -> some View {
        Button(action: submitRegistration, label: {
            Text("SIGN UP")
                .bold()
        }).buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeForeground))
    }

    private func submitRegistration() {
        let registrationDetails = RegistrationDetails(name: name,
                                                      phone: phone,
                                                      email: email,
                                                      password: password)
        interactor.register(details: registrationDetails)
    }
}
