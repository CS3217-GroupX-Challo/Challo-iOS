//
//  GuideLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class GuideLoginAPI: LoginAPI {
    let networkManager = APINetwork.getNetworkManager()
    let guideParser = GuideAPIParser()
    let userTypeUrl = "/guide"

    let userAPI: UserAPIProtocol
    
    init(userAPI: UserAPIProtocol) {
        self.userAPI = userAPI
    }
    
    func parseUserTypeJson(json: JSON) -> User? {
        guard let data = json[Key.data] as? JSON else {
            return nil
        }
        return guideParser.convertJSONToGuide(json: data)
    }
}
