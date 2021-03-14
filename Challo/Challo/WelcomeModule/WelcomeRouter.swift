import SwiftUI

class WelcomeRouter {

    func makeRegisterPageView() -> some View {
        let presenter = LoginPresenter(interactor: LoginInteractor())
        return RegisterPage(loginPresenter: presenter)
    }

    func makeLoginPageView() -> some View {
        Text("THIS IS THE TEMP LOG IN PAGE")
    }
}
