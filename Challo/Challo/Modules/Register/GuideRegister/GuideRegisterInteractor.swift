//
//  GuideInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

class GuideRegisterInteractor: RegisterInteractor, InteractorProtocol {

    let networkManager = AlamofireManager.alamofireManager
    weak var presenter: RegisterPresenter!

    private let guideUrl = "/guide"

    func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        self.commonRegister(details: json) { [weak self] response in
            guard let self = self else {
                return
            }
            self.registrationProcessCompleted(response: response)
            guard let json = self.createGuideJson(details: details,
                                                  certificate: response.certificate) else {
                return
            }
            self.registerUserType(url: self.guideUrl, body: json)
        }
    }

    private func createGuideJson(details: RegistrationDetails,
                                 certificate: UserCertificate?) -> JSON? {
        guard let userId = certificate?.userId else {
            return nil
        }
        var json = createRegisterJson(details: details)
        json.removeValue(forKey: "password")
        json["userId"] = userId
        return json
    }
}
