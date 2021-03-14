import SwiftUI

class LoginPresenter: ObservableObject {

    private var interactor: LoginInteractor

    init(interactor: LoginInteractor) {
        self.interactor = interactor
    }

    func makeLoginWithFacebookButton() -> some View {
        FacebookLoginButton(action: self.interactor.logInWithFacebook)
    }
}
