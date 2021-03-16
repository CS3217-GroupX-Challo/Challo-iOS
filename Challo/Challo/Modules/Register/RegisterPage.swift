import SwiftUI

struct RegisterPage: View {
    var loginPresenter: LoginPresenter
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
                        RegisterForm(name: $registerPresenter.name,
                                     phone: $registerPresenter.phone,
                                     email: $registerPresenter.email,
                                     password: $registerPresenter.password)
                        registerPresenter.makeRegisterButton()
                    }
                }
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height / 2)
                .frame(width: geometry.size.width * 0.85,
                       height: geometry.size.height,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        .ignoresSafeArea()
        .alert(isPresented: $registerPresenter.isShowingRegisterFailureAlert) {
            Alert(title: Text("Unable to sign up"),
                  message: Text("Please check that you've filled in all your details"),
                  dismissButton: .default(Text("Close")))
        }
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        let (view, _) = RegisterModule.assemble()
        return view
    }
}
