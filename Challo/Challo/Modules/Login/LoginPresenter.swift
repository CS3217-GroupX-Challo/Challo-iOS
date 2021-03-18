import SwiftUI

protocol LoginPresenter: AnyObject {

    var interactor: LoginInteractor! { get set }
    var router: LoginRouter? { get set }

    var email: String { get set }
    var password: String { get set }
    var isShowingLoginFailureAlert: Bool { get set }

    func makeLoginWithFacebookButton() -> AnyView
    func makeLoginButton() -> AnyView
    func makeRegisterButton() -> AnyView
    func showLoginFailureAlert()
}

extension LoginPresenter {

    func makeLoginWithFacebookButton() -> AnyView {
        AnyView(FacebookLoginButton(action: interactor.logInWithFacebook))
    }

    func makeLoginButton() -> AnyView {
        AnyView(
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
        )
    }

    func makeRegisterButton() -> AnyView {
        guard let router = self.router else {
            fatalError("LoginRouter not setup")
        }
        return AnyView(NavigationLink(destination: router.getRegistrationPage()) {
            Text("SIGN UP")
                .bold()
        }.buttonStyle(BorderedButtonStyle(borderColor: .themePrimary,
                                          foregroundColor: .themePrimary)))
    }

    func showLoginFailureAlert() {
        self.isShowingLoginFailureAlert = true
    }
}
