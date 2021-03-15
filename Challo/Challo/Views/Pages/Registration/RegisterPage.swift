import SwiftUI

struct RegisterPage: View {
    @ObservedObject var loginPresenter: LoginPresenter
    @ObservedObject var registerPresenter: RegisterPresenter

    var body: some View {
        LoginRegisterBackground {
            GeometryReader { geometry in
                VStack {
                    ChalloTitle()
                    Card {
                        Text("Sign up")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.themePrimary)
                        HStack {
                            loginPresenter.makeLoginWithFacebookButton()
                        }
                        RegisterForm(username: $registerPresenter.userName,
                                     firstName: $registerPresenter.firstName,
                                     lastName: $registerPresenter.lastName,
                                     email: $registerPresenter.email,
                                     password: $registerPresenter.password)
                    }
                }
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height / 2)
                .frame(width: geometry.size.width * 0.85,
                       height: geometry.size.height,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage(loginPresenter: LoginPresenter(interactor: LoginInteractor()),
                     registerPresenter: RegisterPresenter(interactor: RegisterInteractor()))
    }
}
