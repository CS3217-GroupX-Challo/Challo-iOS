import SwiftUI

class LoginPresenter: PresenterProtocol {

    var interactor: LoginInteractor!
    var router: LoginRouter?

    func makeLoginWithFacebookButton() -> some View {
        return FacebookLoginButton(action: interactor.logInWithFacebook)
    }

    func makeLoginButton() -> some View {
        Button(action: {}, label: {
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
