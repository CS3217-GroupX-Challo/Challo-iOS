import SwiftUI

class RegisterPresenter: PresenterProtocol {

    var interactor: RegisterInteractor!
    var router: RegisterRouter?

    @Published var userName = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""

    func makeRegisterButton() -> some View {
        Button(action: submitRegistration, label: {
            Text("SIGN UP")
                .bold()
        }).buttonStyle(BorderedButtonStyle(borderColor: .themePrimary, foregroundColor: .themeForeground))
    }

    private func submitRegistration() {
        let registrationDetails = RegistrationDetails(userName: userName,
                                                      firstName: firstName,
                                                      lastName: lastName,
                                                      email: email,
                                                      password: password)
        interactor.register(details: registrationDetails)
    }
}
