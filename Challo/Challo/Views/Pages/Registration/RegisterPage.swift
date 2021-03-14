import SwiftUI

struct RegisterPage: View {
    @ObservedObject var loginPresenter: LoginPresenter

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                Card {
                    Text("Sign up")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.yellow)
                    HStack {
                        loginPresenter.makeLoginWithFacebookButton()
                    }
                    RegisterForm()
                }
                .position(x: geometry.size.width / 2,
                          y: geometry.size.height / 2)
                .frame(width: geometry.size.width * 0.85,
                       height: geometry.size.height,
                       alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity,
               alignment: .center)
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage(loginPresenter: LoginPresenter(interactor: LoginInteractor()))
    }
}
