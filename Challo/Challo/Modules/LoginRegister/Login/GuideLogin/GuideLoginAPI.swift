//
//  GuideLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class GuideLoginAPI: LoginAPI {
    let networkManager = APINetwork.getNetworkManager()
    let guideParser = GuideAPIParser()
    let userAPI = UserAPI(userParser: UserAPIParser(),
                          networkManager: APINetwork.getNetworkManager())
    let userTypeUrl = "/guide"

    func parseUserTypeJson(json: JSON) -> User? {
        guard let data = json[Key.data] as? JSON else {
            return nil
        }
        return guideParser.convertJSONToGuide(json: data)
    }
}
