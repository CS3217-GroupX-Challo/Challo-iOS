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
            guard let profileData = result as? [String : Any] else {
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            let email = profileData["email"] as? String
            guard let token = AccessToken.current?.tokenString else {
                print("Token not set")
                self.loginDelegate?.loginProcessCompleted(loginResponse: failureResponse)
                return
            }
            let successResponse = LoginResponse(success: true, email: email, name: email, token: token)
            self.loginDelegate?.loginProcessCompleted(loginResponse: successResponse)
        }
    }
}
