//
//  GuideInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

class GuideRegisterInteractor: RegisterInteractor, InteractorProtocol {

    let networkManager = AlamofireManager.alamofireManager
    weak var presenter: RegisterPresenter!

    private let registrationLogic = GuideRegistrationLogic()
    
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
