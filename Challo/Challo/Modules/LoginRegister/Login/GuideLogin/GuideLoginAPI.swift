//
//  GuideLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class GuideLoginAPI: LoginAPI {

    let guideParser = GuideAPIParser()
    let userAPI = UserAPI()
    let userTypeUrl = "/guide"

    func parseUserTypeJson(json: JSON) -> User? {
        guard let data = json[Key.data] as? JSON else {
            return nil
        }
        return guideParser.convertJSONToGuide(json: data)
    }
}
