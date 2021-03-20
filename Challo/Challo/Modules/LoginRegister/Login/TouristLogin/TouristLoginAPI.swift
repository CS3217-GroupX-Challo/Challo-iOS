//
//  TouristLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class TouristLoginAPI: LoginAPI {

    let userTypeUrl = "/tourist"

    let networkManager = AlamofireManager.alamofireManager

    func parseUserTypeJson(json: JSON) -> User? {
        convertJSONToTourist(json: json)
    }
}
