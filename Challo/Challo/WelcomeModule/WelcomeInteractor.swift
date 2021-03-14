import SwiftUI

class WelcomeInteractor {

    private let router = WelcomeRouter()

    func createLoginButton() -> some View {
        NavigationLink(
            destination: router.makeLoginPageView()) {
            Text("Login")
        }
    }

    func createRegisterButton() -> some View {
        NavigationLink(
            destination: router.makeRegisterPageView()) {
            Text("Register")
        }
    }
}
