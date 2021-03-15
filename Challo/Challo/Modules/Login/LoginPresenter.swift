import SwiftUI

class LoginPresenter: ObservableObject {

    private var interactor: LoginInteractor
    private var router = LoginRouter()

    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }

    func makeLoginWithFacebookButton() -> some View {
        FacebookLoginButton(action: self.interactor.logInWithFacebook)
    }

    func makeLoginButton() -> some View {
        Button(action: {}, label: {
            Text("SIGN IN")
                .bold()
        }).buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                           foregroundColor: .themePrimary))
    }

    func makeRegisterButton() -> some View {
        NavigationLink(destination: router.getRegistrationPage()) {
            Text("SIGN UP")
                .bold()
        }.buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                          foregroundColor: .themePrimary))
    }
}
