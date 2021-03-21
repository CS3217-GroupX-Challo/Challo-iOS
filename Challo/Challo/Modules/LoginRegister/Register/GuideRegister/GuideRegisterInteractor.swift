//
//  GuideInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

class GuideRegisterInteractor: RegisterInteractor, InteractorProtocol {

    weak var presenter: RegisterPresenter!

    private let registerAPI: RegisterAPI
    var certificateManager = CertificateManager()

    init(registerAPI: RegisterAPI) {
        self.registerAPI = registerAPI
    }

    convenience init() {
        self.init(registerAPI: GuideRegistrationAPI())
    }
    
    func register(details: RegistrationDetails) {
        registerAPI.register(details: details) { [weak self] response in
            if response.error != nil {
                self?.presenter.showRegisterFailureAlert()
                return
            }
            self?.registrationProcessCompleted(response: response)
        }
    }
}
