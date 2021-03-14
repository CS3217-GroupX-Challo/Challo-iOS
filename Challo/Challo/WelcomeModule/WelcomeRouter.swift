import SwiftUI

class WelcomeRouter {

    func makeRegisterPageView() -> some View {
        let loginPresenter = LoginPresenter(interactor: LoginInteractor())
        let registerPresenter = RegisterPresenter(interactor: RegisterInteractor())
        return RegisterPage(loginPresenter: loginPresenter, registerPresenter: registerPresenter)
    }

    func makeLoginPageView() -> some View {
        let presenter = LoginPresenter(interactor: LoginInteractor())
        return LoginPage(loginPresenter: presenter)
    }
}
