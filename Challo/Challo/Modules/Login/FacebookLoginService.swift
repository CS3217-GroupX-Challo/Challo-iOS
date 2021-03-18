import FBSDKLoginKit
import Dispatch

class FacebookLoginService: LoginService {

    weak var loginDelegate: LoginDelegate?
    private var manager = LoginManager()

    func login() {
        let failureResponse = UserAPIResponse(success: false)

        manager.logIn(permissions: ["public_profile", "email"],
                      from: nil) { result, err in
            ApplicationDelegate.initializeSDK(nil)
            if err != nil {
                ChalloLogger.logger.log("Facebook error: \(err!.localizedDescription)")
                self.loginDelegate?.loginProcessCompleted(response: failureResponse)
                return
            }

            guard let isCancelled = result?.isCancelled, !isCancelled else {
                self.loginDelegate?.loginProcessCompleted(response: failureResponse)
                return
            }

            self.makeGraphRequest()
        }
    }

    private func makeGraphRequest() {
        let request = GraphRequest(graphPath: "me",
                                   parameters: ["fields": "email"])
        let failureResponse = UserAPIResponse(success: false)

        request.start { _, result, _ in
            guard let profileData = result as? [String: Any] else {
                self.loginDelegate?.loginProcessCompleted(response: failureResponse)
                return
            }
            guard let email = profileData["email"] as? String else {
                ChalloLogger.logger.log("Failed to retrieve email from Facebook")
                return
            }
            guard let token = AccessToken.current?.tokenString else {
                ChalloLogger.logger.log("Token from Facebook not set")
                self.loginDelegate?.loginProcessCompleted(response: failureResponse)
                return
            }
            // TODO: Change certificate generation once backend supports socials login
            let certificate = UserCertificate(name: email, email: email, token: token, userId: "TEMP")
            let successResponse = UserAPIResponse(success: true, certificate: certificate)
            self.loginDelegate?.loginProcessCompleted(response: successResponse)
        }
    }
}
