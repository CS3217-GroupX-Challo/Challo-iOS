//
//  GuideRegistrationLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class GuideRegistrationAPI: RegisterAPI {
    let networkManager = APINetwork.getNetworkManager()
    let guideParser = GuideAPIParser()
    let userAPI = UserAPI(userParser: UserAPIParser(),
                          networkManager: APINetwork.getNetworkManager())
    let userTypeUrl = "/guide"

    func createUserTypeJSON(details: RegistrationDetails, certificate: UserCertificate?) -> JSON? {
        guard let userId = certificate?.userId else {
            return nil
        }
        var json = createRegisterJson(details: details)
        json.removeValue(forKey: "password")
        json["userId"] = userId
        return json
    }

    func parseUserTypeJSON(json: JSON) -> User? {
        guard let data = json[Key.data] as? JSON else {
            return nil
        }
        let guide = guideParser.convertJSONToGuide(json: data)
        return guide
    }
}
