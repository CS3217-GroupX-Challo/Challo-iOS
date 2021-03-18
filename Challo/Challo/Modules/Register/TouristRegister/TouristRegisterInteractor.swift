//
//  TouristRegisterInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 17/3/21.
//

class TouristRegisterInteractor: RegisterInteractor {

    private let touristUrl = "/guide"

    override func register(details: RegistrationDetails) {
        let json = createRegisterJson(details: details)
        self.commonRegister(details: json) { response in
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
