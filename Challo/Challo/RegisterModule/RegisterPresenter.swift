import SwiftUI

class RegisterPresenter: ObservableObject {

    var interactor: RegisterInteractor
    @Published var userName = ""
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""

    init(interactor: RegisterInteractor) {
        self.interactor = interactor
    }

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
