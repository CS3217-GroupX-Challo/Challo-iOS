import SwiftUI

struct WelcomePage: View {

    private var interactor: WelcomeInteractor

    init(interactor: WelcomeInteractor) {
        self.interactor = interactor
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Text("Welcome to Challo")
                    .font(.title)
                interactor.createRegisterButton()
                    .font(.title)
                interactor.createLoginButton()
                    .font(.title)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WelcomePage_Previews: PreviewProvider {
    static var previews: some View {
        WelcomePage(interactor: WelcomeInteractor())
    }
}
