import FBSDKLoginKit
import Dispatch

class FacebookLoginService: LoginService {

    weak var loginDelegate: LoginDelegate?
    private var manager = LoginManager()

    func login() {
        let failureResponse = LoginResponse(success: false)

        manager.logIn(permissions: ["public_profile", "email"],
                      from: nil) { result, err in
            ApplicationDelegate.initializeSDK(nil)
            if err != nil {
                print("ERROR: \(err!.localizedDescription)")
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }

            guard let isCancelled = result?.isCancelled, !isCancelled else {
                print("User cancelled login process")
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }

            self.makeGraphRequest()
        }
    }

    private func makeGraphRequest() {
        let request = GraphRequest(graphPath: "me",
                                   parameters: ["fields": "email"])
        let failureResponse = LoginResponse(success: false)

        request.start { _, result, _ in
            guard let profileData = result as? [String: Any] else {
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            guard let email = profileData["email"] as? String else {
                print("Failed to retrieve email")
                return
            }
            guard let token = AccessToken.current?.tokenString else {
                print("Token not set")
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            // TODO: Change certificate generation once backend supports socials login
            let certificate = UserCertificate(name: email, email: email, token: token, userId: "TEMP")
            let successResponse = LoginResponse(success: true, certificate: certificate)
            self.loginDelegate?.loginProcessCompleted(loginResponse: successResponse)
        }
    }
}
