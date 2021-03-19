//
//  GuideRegistrationLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class GuideRegistrationLogic: RegistrationLogic {

    let userTypeUrl = "/tourist"
    let networkManager = AlamofireManager.alamofireManager

    func createUserTypeJSON(details: RegistrationDetails, certificate: UserCertificate?) -> JSON? {
        guard let userId = certificate?.userId else {
            return nil
        }
        var json = createRegisterJson(details: details)
        json.removeValue(forKey: "password")
        json["userId"] = userId
        return json
    }
}
