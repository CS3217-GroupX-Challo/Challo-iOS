import SwiftUI

protocol LoginPresenter: PresenterProtocol where Interactor: LoginInteractor, Router: LoginRouter {

    var interactor: Interactor! { get set }
    var router: Router? { get set }

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
