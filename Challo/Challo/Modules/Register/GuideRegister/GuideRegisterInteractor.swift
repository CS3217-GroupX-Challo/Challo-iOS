//
//  GuideInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 18/3/21.
//

class GuideRegisterInteractor: RegisterInteractor {

    private let guideUrl = "/guide"

    override func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        self.commonRegister(details: json) { response in
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
