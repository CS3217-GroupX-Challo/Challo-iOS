//
//  TouristRegisterInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristRegisterInteractor: RegisterInteractor, InteractorProtocol {

    let networkManager = AlamofireManager.alamofireManager
    var presenter: RegisterPresenter!

    private let touristUrl = "/guide"

    func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        self.commonRegister(details: json) { [weak self] response in
            guard let self = self else {
                return
            }
            self.registrationProcessCompleted(response: response)
            guard let json = self.createTouristJson(details: details,
                                                    certificate: response.certificate) else {
                return
            }
            self.registerUserType(url: self.touristUrl, body: json)
        }
    }

    private func createTouristJson(details: RegistrationDetails,
                                   certificate: UserCertificate?) -> JSON? {
        guard let userId = certificate?.userId else {
            return nil
        }
        var json = JSON()
        json["userId"] = userId
        return json
    }
}
