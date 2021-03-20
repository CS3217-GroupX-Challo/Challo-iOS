import SwiftUI

protocol LoginPresenter: AnyObject {

    var interactor: LoginInteractor! { get set }
    var router: LoginRouter? { get set }

    var email: String { get set }
    var password: String { get set }
    var isShowingLoginFailureAlert: Bool { get set }

    func login()
    func getRegistrationPage() -> AnyView
    func showLoginFailureAlert()
}

extension LoginPresenter {

    func login() {
        self.interactor.defaultLogin(email: self.email, password: self.password)
    }

    func getRegistrationPage() -> AnyView {
        guard let router = self.router else {
            fatalError("LoginRouter not setup")
        }
        return router.getRegistrationPage()
    }

    func showLoginFailureAlert() {
        self.isShowingLoginFailureAlert = true
    }
}
