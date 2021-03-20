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
                                   parameters: ["fields": "\(Key.fbEmail),\(Key.fbName),\(Key.fbId)"])
        let failureResponse = SocialLoginResponse(success: false)
        request.start { _, result, _ in
            guard let profileData = result as? [String: Any] else {
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }
            guard let email = profileData[Key.fbEmail] as? String else {
                ChalloLogger.logger.log("Failed to retrieve email from Facebook")
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }
            guard let socialId = profileData[Key.fbId] as? String else {
                ChalloLogger.logger.log("Failed to retrieve id from Facebook")
                self.delegate?.socialLoginDidComplete(response: failureResponse)
                return
            }
            guard let name = profileData[Key.fbName] as? String else {
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
