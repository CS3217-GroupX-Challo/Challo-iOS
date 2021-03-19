//
//  LoginLogic.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

protocol LoginLogic: LoginAPI, AnyObject {

    func login(email: String,
               password: String,
               callback: @escaping (UserAPIResponse) -> Void)
}

extension LoginLogic {

    func login(email: String,
               password: String,
               callback: @escaping (UserAPIResponse) -> Void) {
        let json = createLoginJson(email: email, password: password)
        self.commonLogin(credentials: json, callback: { response in
            callback(response)
        })
    }

    func createLoginJson(email: String, password: String) -> JSON {
        var json = JSON()
        json["email"] = email
        json["password"] = password
        return json
    }
}
