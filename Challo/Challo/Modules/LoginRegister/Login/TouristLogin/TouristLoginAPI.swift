//
//  TouristLoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class TouristLoginAPI: LoginAPI {
    let networkManager = APINetwork.getNetworkManager()
    let touristParser = TouristAPIParser()
    let userTypeUrl = "/tourist"

    let userAPI: UserAPIProtocol
    
    init(userAPI: UserAPIProtocol) {
        self.userAPI = userAPI
    }
    
    func parseUserTypeJson(json: JSON) -> User? {
        touristParser.convertJSONToTourist(json: json)
    }
}
