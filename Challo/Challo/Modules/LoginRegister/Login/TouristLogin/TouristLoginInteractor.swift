//
//  TouristLoginInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristLoginInteractor: LoginInteractor, InteractorProtocol {

    let networkManager = AlamofireManager.alamofireManager
    weak var presenter: LoginPresenter!
    private let api = TouristLoginAPI()

    func defaultLogin(email: String, password: String) {
        api.login(email: email, password: password) { [weak self] response in
            if response.error != nil {
                self?.presenter.showLoginFailureAlert()
                return
            }
            self?.loginProcessCompleted(response: response)
        }
    }
}
