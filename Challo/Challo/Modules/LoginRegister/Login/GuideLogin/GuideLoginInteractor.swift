//
//  GuidesLoginInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class GuideLoginInteractor: LoginInteractor, InteractorProtocol {

    weak var presenter: LoginPresenter!
    private let loginLogic = GuideLoginAPI()

    func defaultLogin(email: String, password: String) {
        loginLogic.login(email: email, password: password) { [weak self] response in
            if response.error != nil {
                self?.presenter.showLoginFailureAlert()
                return
            }
            self?.loginProcessCompleted(response: response)
        }
    }
}
