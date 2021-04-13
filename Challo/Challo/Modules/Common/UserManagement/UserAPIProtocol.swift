//
//  UserAPIProtocol.swift
//  Challo
//
//  Created by Shao Yi on 13/4/21.
//

protocol UserAPIProtocol: APIProtocol {
    typealias JSON = NetworkManager.JSON

    func commonLogin(credentials: JSON,
                     callback: @escaping (UserAPIResponse) -> Void)

    func commonRegister(details: JSON,
                        callback: @escaping (UserAPIResponse) -> Void)
    
    func sendUserPostRequest(url: String,
                             body: JSON,
                             callback: @escaping (UserAPIResponse) -> Void)
    
    func updateUserRequest(userId: String,
                           body: JSON,
                           callback: @escaping (UserAPIResponse) -> Void)
}
