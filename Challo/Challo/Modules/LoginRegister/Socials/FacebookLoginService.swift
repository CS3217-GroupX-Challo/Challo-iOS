import FBSDKLoginKit
import Dispatch

class FacebookLoginService: SocialLoginService {

    weak var delegate: SocialLoginDelegate?
    private var manager = LoginManager()

    func login() {
        let failureResponse = SocialLoginResponse(success: false)

        manager.logIn(permissions: ["public_profile", "email"],
                      from: nil) { result, err in
            ApplicationDelegate.initializeSDK(nil)
            if err != nil {
                ChalloLogger.logger.log("Facebook error: \(err!.localizedDescription)")
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }

            guard let isCancelled = result?.isCancelled, !isCancelled else {
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }

            self.makeGraphRequest()
        }
    }

    private func makeGraphRequest() {
        let request = GraphRequest(graphPath: "me",
                                   parameters: ["fields": ["email", "id", "name"]])
        let failureResponse = SocialLoginResponse(success: false)

        request.start { _, result, _ in
            guard let profileData = result as? [String: Any] else {
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }
            guard let email = profileData["email"] as? String else {
                ChalloLogger.logger.log("Failed to retrieve email from Facebook")
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }
            guard let socialId = profileData["id"] as? String else {
                ChalloLogger.logger.log("Failed to retrieve id from Facebook")
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }
            guard let name = profileData["name"] as? String else {
                ChalloLogger.logger.log("Failed to retrieve name from Facebook")
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }
            guard (AccessToken.current?.tokenString) != nil else {
                ChalloLogger.logger.log("Token from Facebook not set")
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }

            let successResponse = SocialLoginResponse(success: true,
                                                      email: email,
                                                      name: name,
                                                      socialId: socialId)
            self.delegate?.socialLoginDidComplete(response: successResponse)
        }
    }
}
