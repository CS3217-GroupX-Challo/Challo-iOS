//
//  TouristRegisterLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class TouristRegistrationAPI: RegisterAPI {

    let userTypeUrl = "/tourist"
    let networkManager = AlamofireManager.alamofireManager

    func createUserTypeJSON(details: RegistrationDetails, certificate: UserCertificate?) -> JSON? {
        guard let userId = certificate?.userId else {
            return nil
        }
        var json = JSON()
        json["userId"] = userId
        return json
    }

    func parseUserTypeJSON(json: JSON) -> User? {
        let tourist = convertJSONToTourist(json: json)
        return tourist
    }
}
