//
//  TouristLoginInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristLoginInteractor: LoginInteractor, InteractorProtocol {

    weak var presenter: LoginPresenter!
    private let loginAPI: LoginAPI
    var certificateManager: CertificateManager

    init(loginAPI: LoginAPI, certificateManager: CertificateManager) {
        self.loginAPI = loginAPI
        self.certificateManager = certificateManager
    }

    convenience init(certificateManager: CertificateManager) {
        self.init(loginAPI: TouristLoginAPI(), certificateManager: certificateManager)
    }

    func defaultLogin(email: String, password: String) {
        loginAPI.login(email: email, password: password) { [weak self] response in
            if response.error != nil {
                self?.presenter.showLoginFailureAlert()
                return
            }
            self?.loginProcessCompleted(response: response)
        }
    }
}
