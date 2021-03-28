//
//  TouristRegisterLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class TouristRegistrationAPI: RegisterAPI {
    let networkManager = APINetwork.getNetworkManager()
    let userAPI = UserAPI(userParser: UserAPIParser(),
                          networkManager: APINetwork.getNetworkManager())
    let userTypeUrl = "/tourist"
    private let parser = TouristAPIParser()

    func createUserTypeJSON(details: RegistrationDetails, certificate: UserCertificate?) -> JSON? {
        guard let userId = certificate?.userId else {
            return nil
        }
        var json = JSON()
        json["userId"] = userId
        return json
    }

    func parseUserTypeJSON(json: JSON) -> User? {
        guard let data = json[Key.data] as? JSON else {
            return nil
        }
        let tourist = parser.convertJSONToTourist(json: data)
        return tourist
    }
}
