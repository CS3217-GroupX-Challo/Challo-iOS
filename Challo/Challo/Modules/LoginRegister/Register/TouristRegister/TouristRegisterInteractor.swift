//
//  TouristRegisterInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristRegisterInteractor: RegisterInteractor, InteractorProtocol {

    let networkManager = AlamofireManager.alamofireManager
    weak var presenter: RegisterPresenter!

    private let registrationLogic = TouristRegistrationLogic()

    func register(details: RegistrationDetails) {
        registrationLogic.register(details: details) { [weak self] response in
            if response.error != nil {
                self?.presenter.showRegisterFailureAlert()
                return
            }
            self?.registrationProcessCompleted(response: response)
        }
    }
}
