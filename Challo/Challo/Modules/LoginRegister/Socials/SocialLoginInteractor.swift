//
//  SocialLoginInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class SocialLoginInteractor: CertificateManager {

    var loginLogic: LoginLogic
    var registerLogic: RegistrationLogic

    private var facebookLoginService = FacebookLoginService()

    init(loginLogic: LoginLogic, registrationLogic: RegistrationLogic) {
        self.loginLogic = loginLogic
        self.registerLogic = registrationLogic
        facebookLoginService.delegate = self
    }

    func loginWithFacebook() {
        facebookLoginService.login()
    }
}

extension SocialLoginInteractor: SocialLoginDelegate {

    func socialLoginDidComplete(response: SocialLoginResponse) {
        guard let details = createRegistrationDetails(from: response) else {
            return
        }
        // Try to register an account in case of first-time user, then login
        registerLogic.register(details: details) { [weak self] _ in
            self?.loginLogic.login(email: details.email,
                                   password: details.password) { response in
                guard let certificate = response.certificate,
                      response.success else {
                    return
                }
                self?.storeCertificate(certificate: certificate)
            }
        }
    }

    private func createRegistrationDetails(from response: SocialLoginResponse) -> RegistrationDetails? {
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
