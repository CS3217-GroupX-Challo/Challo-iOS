//
//  SocialLoginInteractor.swift
//  Challo
//
//  Created by Tan Le Yang on 19/3/21.
//

class SocialLoginInteractor {

    var loginAPI: LoginAPI
    var registerAPI: RegisterAPI
    var certificateManager: CertificateManager

    private var facebookLoginService = FacebookLoginService()

    init(loginAPI: LoginAPI, registerAPI: RegisterAPI, certificateManager: CertificateManager) {
        self.loginAPI = loginAPI
        self.registerAPI = registerAPI
        self.certificateManager = certificateManager
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
        registerAPI.register(details: details) { [weak self] _ in
            self?.loginAPI.login(email: details.email,
                                 password: details.password) { response in
                guard let certificate = response.certificate,
                      response.success else {
                    return
                }
                self?.certificateManager.storeCertificate(certificate: certificate)
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
