//
//  TouristRegisterInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristRegisterInteractor: RegisterInteractor, InteractorProtocol {

    weak var presenter: RegisterPresenter!
    var certificateManager: CertificateManager

    private let registerAPI: RegisterAPI
    
    init(registerAPI: RegisterAPI, certificateManager: CertificateManager) {
        self.registerAPI = registerAPI
        self.certificateManager = certificateManager
    }

    convenience init(certificateManager: CertificateManager) {
        self.init(registerAPI: TouristRegistrationAPI(), certificateManager: certificateManager)
    }

    func register(details: RegistrationDetails) {
        registerAPI.register(details: details) { [weak self] response in
            if response.error != nil,
               !response.success {
                self?.presenter.showRegisterFailureAlert()
                return
            }
            self?.registrationProcessCompleted(response: response)
        }
    }
}
