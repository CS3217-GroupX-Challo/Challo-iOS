import SwiftUI

class LoginPresenter: PresenterProtocol {

    var interactor: LoginInteractor!
    var router: LoginRouter?

    @Published var email = ""
    @Published var password = ""

    func makeLoginWithFacebookButton() -> some View {
        FacebookLoginButton(action: interactor.logInWithFacebook)
    }

    func makeLoginButton() -> some View {
        Button(action: { [weak self] in
            guard let self = self else {
                return
            }
            self.interactor.defaultLogin(email: self.email, password: self.password)
        }, label: {
            Text("SIGN IN")
                .bold()
        }).buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                           foregroundColor: .themePrimary))
    }

    func makeRegisterButton() -> some View {
        guard let router = self.router else {
            fatalError("LoginRouter not setup")
        }
        return NavigationLink(destination: router.getRegistrationPage()) {
            Text("SIGN UP")
                .bold()
        }.buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                          foregroundColor: .themePrimary))
    }
}
