//
//  TouristLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class TouristLoginAPI: LoginAPI {

    let userAPI = UserAPI()
    let touristParser = TouristAPIParser()
    let userTypeUrl = "/tourist"

    func parseUserTypeJson(json: JSON) -> User? {
        touristParser.convertJSONToTourist(json: json)
    }
}
