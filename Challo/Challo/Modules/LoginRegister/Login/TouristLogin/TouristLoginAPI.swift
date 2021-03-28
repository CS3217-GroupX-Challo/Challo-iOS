//
//  TouristLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class TouristLoginAPI: LoginAPI {
    let networkManager = APINetwork.getNetworkManager()
    let userAPI = UserAPI(userParser: UserAPIParser(),
                          networkManager: APINetwork.getNetworkManager())
    let touristParser = TouristAPIParser()
    let userTypeUrl = "/tourist"

    func parseUserTypeJson(json: JSON) -> User? {
        touristParser.convertJSONToTourist(json: json)
    }
}
