//
//  TouristRegisterInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristRegisterInteractor: RegisterInteractor, InteractorProtocol {

    weak var presenter: RegisterPresenter!

    private let registerAPI: RegisterAPI
    
    init(registerAPI: TouristRegistrationAPI) {
        self.registerAPI = registerAPI
    }

    convenience init() {
        self.init(registerAPI: TouristRegistrationAPI())
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
