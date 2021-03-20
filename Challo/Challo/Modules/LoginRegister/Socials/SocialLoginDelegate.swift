//
//  SocialLoginDelegate.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

protocol SocialLoginDelegate: AnyObject {

    func socialLoginDidComplete(response: SocialLoginResponse)
}

extension SocialLoginDelegate {

    func createRegistrationDetails(from response: SocialLoginResponse) -> RegistrationDetails? {
        guard let name = response.name,
              let email = response.email,
              let password = response.socialId,
              response.success else {
            return nil
        }
        return RegistrationDetails(name: name,
                                   phone: nil,
                                   email: email,
                                   password: password)
    }
}
