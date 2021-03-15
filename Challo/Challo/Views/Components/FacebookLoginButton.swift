import SwiftUI

struct FacebookLoginButton: View {

    let action: () -> Void

    var body: some View {
        Button(action: action, label: {
            HStack {
                Image.facebookIcon
                Text("Login with Facebook")
                    .fontWeight(.bold)
            }
        })
    }
}

struct FacebookLogin_Previews: PreviewProvider {
    static var previews: some View {
        FacebookLoginButton(action: { })
    }
}
