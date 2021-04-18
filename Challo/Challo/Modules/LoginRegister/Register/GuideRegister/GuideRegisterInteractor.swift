//
//  GuideInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

class GuideRegisterInteractor: RegisterInteractor {

    weak var presenter: GuideRegisterPresenter!

    private let registerAPI: RegisterAPI
    var certificateManager: CertificateManager

    init(registerAPI: RegisterAPI, certificateManager: CertificateManager) {
        self.registerAPI = registerAPI
        self.certificateManager = certificateManager
    }
    
    func register(details: RegistrationDetails) {
        registerAPI.register(details: details) { [weak self] response in
            if response.error != nil {
                self?.presenter.showRegisterFailureAlert()
                return
            }
            self?.registrationProcessCompleted(response: response)
            self?.presenter.registrationComplete = true
        }
    }
}
