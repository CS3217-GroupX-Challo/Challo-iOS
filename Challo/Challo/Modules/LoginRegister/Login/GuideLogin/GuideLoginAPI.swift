//
//  GuideLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class GuideLoginAPI: LoginAPI, GuideAPI {

    let userTypeUrl = "/guide"
    
    let networkManager = AlamofireManager.alamofireManager

    func parseUserTypeJson(json: JSON) -> User? {
        convertJSONToGuide(json: json)
    }
}
